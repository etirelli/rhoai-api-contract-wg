# openapi-compat

Provider-agnostic engine for checking OpenAPI compatibility against
immutable baselines, following the [architecture proposal](../../docs/architecture/proposal.md)'s
module interface: every module reads the same descriptor-driven input and
emits the same finding shape.

- **`checker.py`** — resolves baselines by exact Git SHA, invokes the
  descriptor's declared generator adapter to produce a fresh candidate,
  verifies it against the committed artifact, and runs a pinned `oasdiff`
  check scoped to the contract's `matchPath`. No provider-specific paths,
  tool versions, or bundling logic live here.
- **`adapters.py`** — the reviewed, registered candidate-generation
  adapters. Candidate generation is inherently provider-specific (every repo
  bundles or generates its spec differently), so this is a small fixed
  registry rather than a hook that executes arbitrary descriptor-supplied
  commands. A descriptor naming an unregistered adapter fails closed. See
  the adapter list in [`schemas/contract-set.schema.json`](../../schemas/contract-set.schema.json).
- **`tests/test_checker.py`** — regression tests against a synthetic fixture
  repository, so this module's own tests never depend on a real provider.

## Provider-side usage

A provider registers one or more contracts in a `ContractSet` descriptor
(conventionally `.rhoai/contracts.yaml` in the provider repository) and runs:

```bash
python3 <central-repo>/cmd/rhoai-contract/cli.py check \
  --repo . \
  --contract-set .rhoai/contracts.yaml \
  --baseline-ref <full-git-sha> \
  --output-dir /tmp/contract-report
```

See [`docs/onboarding/openapi-compat.md`](../../docs/onboarding/openapi-compat.md)
for the full onboarding walkthrough, and
`opendatahub-io/model-registry`'s `.rhoai/contracts.yaml` and
`docs/model-catalog-compatibility.md` for a concrete, working example (the
Model Catalog pilot).

## Placeholder location

This module is hosted in the working-group repository (`api_contract`),
standing in for `api-contract-central` until that repository exists — see
the root [`README.md`](../../README.md) and
[`tracking/DECISIONS.md`](../../tracking/DECISIONS.md) (D-014). Paths used
by provider repos today (e.g. `cmd/rhoai-contract/cli.py`) will need to be
repointed once the official repository is created and referenced instead.
