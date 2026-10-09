# Model Catalog–Dashboard API Contract Pilot

- **Status:** Proposed; awaiting pilot approval
- **Source of truth:** [One-page stakeholder brief](../stakeholder-brief.md)
- **Tracking:** [RHOAIENG-96904](https://redhat.atlassian.net/browse/RHOAIENG-96904)
- **Updated:** October 9, 2026
- **Proposed execution:** October 5–16, 2026; requires re-acceptance before scheduling
- **Proposed recommendation date:** October 16, 2026; follows the re-accepted window

## Decision

Make the first executable two-week slice one provider/consumer seam: the **Model Catalog REST API
consumed by the Dashboard Model Catalog BFF**. This document elaborates the stakeholder brief and
turns that scope into a safe implementation plan. Pilot approval, the exact wire version, the
supported-release revision, and a re-accepted execution window remain prerequisites.

The broader cohort includes `opendatahub-operator` and `workbenches-operator`, with Dashboard as a
consumer. Operator/CRD checks and a multi-component release matrix are follow-on work, rather than
deliverables of this first slice. Other interfaces require a separate scope decision.

## Why this pilot

The Dashboard gap analysis found no consumer-facing contract tests in the ten assessed upstream
repositories, while Dashboard frequently discovered provider failures late. The Model Catalog seam
provides a bounded proof of earlier compatibility feedback for a service used by Dashboard.

The pilot combines a report-only OpenAPI comparison with provider-facing consumer coverage.
Existing Dashboard tests may provide scaffolding, but tests of a BFF response alone do not prove
the provider REST contract. The consumer profile must name the actual Model Catalog operations,
fields, status codes, and behavior Dashboard relies on.

## Upstream facts from the October 9 review

These facts were verified against the public upstream repositories on October 9, 2026. They are
review evidence, not baseline selections:

- `opendatahub-io/model-registry` has the expected Catalog source at
  `api/openapi/src/catalog-v1.yaml`, plugin sources under `api/openapi/src/plugins/*-v1.yaml`, and
  a bundled artifact at `api/openapi/catalog-v1.yaml`.
- `make api/openapi/catalog-v1.yaml` invokes
  `scripts/merge_catalog_specs.sh catalog-v1.yaml`; `scripts/merge_catalog_specs.sh --check
  catalog-v1.yaml` can verify the committed bundle without rewriting it.
- The provider Makefile pins `mikefarah/yq/v4` at `v4.45.1`. Its `openapi-generator-cli`
  installation is not currently pinned, so spec validation must not be treated as reproducible
  until that is corrected or replaced with a pinned validation target.
- The provider's current bundled Catalog paths use `/api/model_catalog/v1/...`. The single-model
  lookup path uses `{model_name+}`, not a simple `{model_name}` parameter.
- The provider workflow `check-openapi-spec-pr.yaml` only triggers on changes to
  `api/openapi/model-registry.yaml`. When it does run, `make openapi/validate` checks all four
  bundled specs; the problem is the path filter, not the Makefile target.
- The current Dashboard BFF constructs `ModelCatalogAPIPath` as
  `/api/model_catalog/v1alpha1`. This conflicts with the provider's current `/v1` Catalog paths and
  must be resolved before the consumer profile can claim a confirmed boundary.

No mutable `main` revision from either repository is a valid baseline. The pilot must select exact
immutable revisions and record their content digests.

## Required lifecycle

The implementation follows the operating agreement:

1. **Register the relationship once.** Record the stable contract ID, provider and consumer owners,
   support level, applicability, source paths, reliance paths, and expected suite IDs in the working
   group's pointer catalog.
2. **Generate the candidate on every provider pull request.** Use the prospective merge commit and
   the provider's pinned deterministic bundling target. Never trust a stale committed artifact as
   the candidate.
3. **Resolve protected inputs by exact reference.** Fetch the rolling accepted baseline, applicable
   supported-release baselines, policy, and registered consumer profile from immutable revisions.
   Verify full Git SHAs and content digests before using them.
4. **Run structural and behavioral evidence.** Structural comparison and schema-aware consumer
   profile verification are both required. Provider-native behavior tests cover semantics that a
   schema diff cannot prove.
5. **Publish a complete result.** The result names the candidate and baseline revisions, policy and
   tool versions, findings, affected consumer, suite coverage, and remediation. Report-only mode is
   visibly non-enforcing.
6. **Promote only after merge.** A trusted post-merge workflow or a separately reviewed working
   group pull request advances the rolling pointer to a new immutable snapshot. A provider pull
   request cannot approve or advance its own baseline.

## Implementation plan

### 1. Resolve the contract boundary

Before any workflow is enabled:

- Resolve the wire-version mismatch: provider Catalog `v1` versus Dashboard BFF `v1alpha1`. Confirm
  whether Dashboard needs an update, whether the supported provider revision still serves
  `v1alpha1`, or whether the first pilot must use a different provider revision.
- Confirm the support level with productization. A path or document version alone does not define
  compatibility policy.
- Confirm the exact provider source and bundled output paths at the selected immutable revision.
- Map each Dashboard reliance to the provider operation, method, parameters, response fields, and
  status codes. Preserve `{model_name+}` where the provider uses a catch-all model-name parameter.
- Confirm which authorization and not-found cases can be exercised reproducibly without a cluster.

The likely consumed operations are model and artifact list/lookup, model filter options, labels,
source list, source preview, and source status. The exact list and response fields remain pending
until the wire-version and Dashboard reliance mapping is confirmed.

### 2. Register immutable baselines

Do not add `api/openapi/catalog-v1.baseline.yaml` or another editable copy of the provider schema.
The baseline is an exact provider revision, not a mutable file that a pull request can change.

Create a working-group pointer such as `catalog/model-catalog-dashboard.yaml` that records:

- provider repository and full immutable Git SHA;
- exact bundled artifact path;
  SHA-256 content digest of that artifact;
- rolling accepted snapshot identity;
- applicable supported-release snapshot identity, full SHA, and digest;
- generator and bundling tool version;
- compatibility policy revision;
- registered consumer profile repository, full SHA, path, and digest;
- support level and applicability.

Bootstrap the first rolling pointer through a reviewed working-group pull request. Productization
must separately approve the supported-release pointer. After the pilot, replace manual pointer
advancement with a trusted post-merge workflow that publishes append-only evidence and advances only
the pointer, never the bytes behind an existing snapshot.

### 3. Add the provider pull-request check

Add a provider-owned descriptor that names the Catalog source inputs, deterministic generator,
declared bundled artifact, policy, and baseline strategy. During the pilot the descriptor may live
at `.rhoai/contracts.yaml`; its final schema is a working-group deliverable.

The provider check must:

1. Check out the exact prospective merge commit.
2. Build the provider's pinned `bin/yq` target and run
   `YQ=bin/yq scripts/merge_catalog_specs.sh --check catalog-v1.yaml` to detect stale generated
   artifacts without rewriting the committed file.
3. Validate the OpenAPI document only with a pinned validator. Pinning `yq` alone is insufficient
   if `openapi-generator-cli` remains unpinned.
4. Fetch the rolling and release baselines by the full SHAs recorded in the protected working-group
   pointer; verify each artifact's SHA-256 digest and fail closed if either cannot be resolved.
5. Run the selected OpenAPI compatibility check from an exact tool version or immutable runner
   reference. Do not use `@latest`, `brew`, a moving tag, or an unpinned GitHub Action.
6. Load the registered Dashboard consumer profile at its exact protected SHA and verify that the
   profile is schema-valid before using it.
7. Emit a machine-readable result and PR summary containing candidate SHA, baseline SHAs and
   digests, tool and policy versions, findings, and evidence coverage.

The first provider-local workflow may be report-only while the central reusable runner is not yet
available. Enforcement must wait until the check is supplied by a reusable workflow or Action pinned
to a full commit SHA, with policy and baselines resolved outside the provider pull request's
control. A provider pull request must not be able to weaken the check that assesses it.

### 4. Add the Dashboard consumer profile

Dashboard owns a versioned consumer profile that records the operations, methods, parameters,
required response fields, status codes, and semantic behavior its Model Catalog BFF relies on. The
profile also records the exact provider spec SHA and digest it was verified against.

The verifier must be schema-aware. It must fail when any registered operation, method, parameter,
required response field, or expected status code is missing or narrowed. A shell script that only
checks whether a path exists is insufficient and must not be used as the consumer contract test.

Dashboard's consumer pull-request check verifies the changed profile and usage against the pinned
provider spec. The provider pull-request check separately imports the registered consumer profile
from the working-group pointer so provider changes can name the affected Dashboard reliance. Both
sides must use exact SHAs and digest verification; neither side may fetch `main`.

### 5. Add bounded provider behavior evidence

Extend the provider's existing Catalog Go tests with bounded API-level or service-level cases for
the registered consumer profile. Prefer the existing in-process service or repository test harness;
add an `httptest` boundary only if the current harness cannot represent the relied-on response and
status behavior.

The first profile should cover:

- list models with filters and pagination, including an empty result and a next page;
- model lookup, including not-found behavior;
- filter options;
- artifact and performance-artifact lists, including empty results;
- labels and source list;
- source preview and source status, if Dashboard currently relies on them;
- the authorization cases confirmed to be reproducible without a cluster.

Do not turn Dashboard Cypress or full end-to-end deployment into the provider gate. The evidence
must run in provider CI, remain bounded, and be reproducible locally.

### 6. Preserve honest report-only semantics

During report-only mode:

- compatibility findings and stale-artifact findings are published but do not fail the pull request;
- infrastructure failures fail the workflow: missing baseline, SHA or digest mismatch, unresolvable
  protected pointer, unpinned tool, malformed profile, or missing required result;
- the PR summary explicitly states that findings did not affect merge status;
- the result records the finding count and severity, not only a pass/fail exit code.

This distinction is essential. A report that silently disappears because a tool failed, or a green
check that hides a break, is worse than a visible report-only finding.

### 7. Seed the proof scenarios

Run each scenario from the same pinned tool and baseline configuration:

- remove a consumed response field;
- remove a consumed operation;
- change a consumed field type or narrow a relied-on value;
- add an incompatible required input;
- change source without regenerating the committed bundled artifact;
- add an optional response field;
- add an optional query parameter.

The first five scenarios must produce visible findings in report-only mode. The last two must
produce no compatibility finding. Every result must be reproducible locally and include exact
candidate, baseline, policy, and tool references.

## Deliverables and ownership

| Responsibility | Proposed representative / commitment |
|---|---|
| Facilitation and provider implementation | Edson Tirelli |
| Consumer profile and Dashboard tests | Anthony Coughlin / Dashboard |
| Supported-release revision and matrix | Rishab Prasad / Radim Kubis |
| Pointer, policy, and evidence schemas | API Contract testing infrastructure / working group |
| Execution window | Working group; requires re-acceptance |

The working-group contribution defines the pointer, policy, evidence, and onboarding formats. The
provider contribution adds its descriptor, pinned report-only check, and behavior tests. The
Dashboard contribution adds its registered consumer profile and schema-aware verifier.

## Exit criteria

The pilot succeeds when:

- the wire-version mismatch and supported-release revision are resolved before implementation;
- seeded incompatibilities and stale artifacts are visibly detected;
- an additive change produces no compatibility finding;
- schema-aware consumer profile verification catches a removed or narrowed reliance, not only a
  removed path;
- required behavior evidence passes or has an explicitly approved N/A reason;
- feedback is actionable in under five minutes without a cluster;
- local runs use the same exact baselines, policy, and tool versions as CI;
- at least one real pull request runs without an unexplained false block;
- the scorecard recommends enforce, continue reporting, or adjust scope.

Closeout deliverables are the scorecard, reusable onboarding template, and recommendation.
Enforcement follows stable report-only evidence and owner agreement.

## Guardrails

- Keep canonical contracts, generated artifacts, and provider tests in the provider repository.
- Keep the working-group repository pointer-only; do not copy provider schemas or baselines.
- Resolve baselines, policy, and consumer profiles by full SHA and content digest.
- Never compare a candidate with a baseline that the same pull request can modify.
- Pin every required tool, module, policy, and reusable workflow revision.
- Do not use `main`, `latest`, `@latest`, or a moving tag as a required input.
- Treat descriptors, specs, and test output as untrusted input; do not execute arbitrary commands
  from pull-request-controlled configuration.
- Keep report-only visibly non-enforcing, but fail closed on infrastructure and integrity errors.
- Keep Dashboard full end-to-end tests out of the provider pull-request gate.
- Make exceptions explicit, reviewed, auditable, and time-limited.
