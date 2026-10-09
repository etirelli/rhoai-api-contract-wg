# Onboarding a provider to the openapi-compat check

This generalizes the Model Catalog pilot's original checker into a reusable
module so a second provider never needs to copy or reimplement its logic
(see [`tracking/DECISIONS.md`](../../tracking/DECISIONS.md), D-014). Only the
Model Catalog pilot has gone through these steps so far
([`opendatahub-io/model-registry`](https://github.com/opendatahub-io/model-registry)'s
`.rhoai/contracts.yaml`); this document is the generic path for the next one.

## 1. Confirm a generator adapter covers your bundling/generation step

Candidate generation is the one part of this check that is inherently
provider-specific — every repo builds its OpenAPI document differently.
Check [`modules/openapi-compat/adapters.py`](../../modules/openapi-compat/adapters.py)
for the currently registered adapters:

- **`openapi.bundle.yq-merge`** — your repo already has a shell script that
  merges source YAML files into a bundled document using `yq` (the pattern
  Model Catalog uses with `scripts/merge_catalog_specs.sh`).
- **`openapi.static`** — your OpenAPI document is hand-maintained,
  contract-first, with no generation step.

If neither fits, a new adapter must be added to `adapters.py` and reviewed
centrally — once added, every future repo with the same build pattern reuses
it for free. Do not copy checker logic into your own repository to work
around a missing adapter.

## 2. Write a `ContractSet` descriptor

Create `.rhoai/contracts.yaml` in your repository, validated against
[`schemas/contract-set.schema.json`](../../schemas/contract-set.schema.json).
Minimal shape:

```yaml
apiVersion: contracts.rhoai.io/v1alpha1
kind: ContractSet
metadata:
  name: your-service
spec:
  contracts:
    - id: your-service-v1
      type: openapi
      declaredArtifact: api/openapi/your-service.yaml
      matchPath: "^/api/your-service/v1(/|$)"
      policy:
        oasdiffVersion: "1.33.0"
        flattenAllOf: true
        severityOverrides:
          response-optional-property-removed: warn
      generator:
        adapter: openapi.bundle.yq-merge
        script: scripts/your-bundler.sh
        yqEnvVar: YQ
        sourceDir: api/openapi/src
        sourceGlobs: ["your-service.yaml", "plugins/*.yaml"]
        entrypointArg: your-service.yaml
        output: api/openapi/your-service.yaml
```

Only paths matching `matchPath` are compared; this is how you scope a check
to one bounded interface within a larger bundled document instead of
accidentally gating on every endpoint in the repo (see the "V1 Scope"
section of the [architecture proposal](../../docs/architecture/proposal.md)
— do not include every internal endpoint). A repository with no descriptor,
or a document with no `contracts:` entry naming it, is never checked.

`severityOverrides` lets you promote an oasdiff finding (see
`oasdiff checks changelog` for the full rule catalog) above its default
severity — for example, if consumers rely on an *optional* response field,
its removal defaults to `info` in oasdiff but can be promoted to `warn` so
it surfaces as a finding.

## 3. Install the pinned tools

```sh
GOBIN="$PWD/bin" go install github.com/oasdiff/oasdiff@<version pinned in your descriptor>
# plus however your repo already pins yq
```

`checker.py` rejects any other oasdiff version — including `go install`
builds that print `main` as their display version, by checking the binary's
embedded Go module version instead.

## 4. Run it locally

```bash
baseline_sha=$(git rev-parse refs/remotes/<trusted-remote>/main)
python3 <path-to-this-repo>/cmd/rhoai-contract/cli.py check \
  --repo . \
  --contract-set .rhoai/contracts.yaml \
  --baseline-ref "$baseline_sha" \
  --output-dir /tmp/contract-report
```

Repeat `--baseline-ref` for every applicable supported-release baseline;
every supplied baseline is compared independently. Never pass `main`,
`HEAD`, or an unresolved ref — only full, resolved Git SHAs. Add `--enforce`
once report-only evidence and owner agreement support gating merges.

Read `report.json.status`, not just the exit code: report-only mode exits
`0` even when breaking findings are recorded.

## 5. Add CI

No reusable GitHub Actions workflow is wired to live CI yet — see
[`.github/workflows/provider-openapi-check.yml`](../../.github/workflows/provider-openapi-check.yml)
for the drafted (not yet exercised) shape, and
[`tracking/ACTIONS.md`](../../tracking/ACTIONS.md) (A-006) for status. Until
then, run the check manually or via a provider-local job that shells out to
the command above, same as the Model Catalog pilot currently does.

## 6. Register the contract with the working group

Once proven locally, register the descriptor's location (repo, path,
revision) as a pointer so baselines, consumer profiles, and support level
can be tracked centrally — see the Ownership Model and "Who advances a
baseline, and when" sections of the
[architecture proposal](../../docs/architecture/proposal.md). A descriptor
existing in a repository does not itself make that repository part of the
gated cohort; registration is a separate, reviewed step.
