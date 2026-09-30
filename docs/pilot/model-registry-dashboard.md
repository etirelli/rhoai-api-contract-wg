# Model Registry–Dashboard API Contract Pilot

- **Status:** Proposed for working-group approval
- **Tracking:** [RHOAIENG-96904](https://redhat.atlassian.net/browse/RHOAIENG-96904)
- **Proposed execution:** October 5–16, 2026
- **Recommendation date:** October 16, 2026

## Decision

Use Anthony Coughlin's broader architecture proposal as the target operating model, but make the
first executable two-week slice one provider/consumer seam: the **Model Registry REST v1 API
consumed by the Dashboard Model Registry BFF**.

The longer pilot cohort remains `model-registry`, `opendatahub-operator`, and
`workbenches-operator`, with Dashboard as a consumer. Only `model-registry` is implemented in this
first slice. Model Catalog, MCP Catalog, MaaS, CRD compatibility, and a multi-component release
matrix are deferred until this slice demonstrates a stable positive and negative signal.

## Why this pilot

Anthony's gap analysis found that none of the ten assessed upstream repositories had
consumer-facing contract tests, while Dashboard frequently discovered provider failures late. The
Model Registry seam is bounded and already has the prerequisites for a fast proof:

- The provider keeps versioned OpenAPI source and a generated bundled document in its repository.
- The Dashboard BFF has explicit Model Registry provider-client code and a shared contract-test
  framework.
- List, get, pagination, not-found, and authorization behavior can be exercised without a full
  cluster.

The existing Dashboard Model Registry contract test is useful scaffolding, but it currently checks
only the Dashboard `/api/v1/model_registry` BFF response. The pilot must add provider-facing
coverage; it must not count that test as already proving the Model Registry REST contract.

## Contract boundary

| Item | Pilot definition |
|---|---|
| Provider | `opendatahub-io/model-registry` |
| Canonical source | `api/openapi/src/model-registry-v1.yaml` plus `api/openapi/src/lib/*.yaml` |
| Generated candidate | `api/openapi/model-registry-v1.yaml`, regenerated with the repository Make target |
| Consumer | Dashboard Model Registry BFF in `opendatahub-io/odh-dashboard` |
| Existing consumer test | `packages/model-registry/contract-tests/__tests__/testModelRegistryContract.test.ts` |
| Required provider gate | Pinned `oasdiff`, initially report-only |
| Optional runtime check | Bounded Schemathesis smoke test only if provider startup is inexpensive |

The first consumer profile covers:

1. `GET /api/model_registry/v1/registered_models` — list shape, empty result, pagination token,
   ordering, and filtering.
2. `GET /api/model_registry/v1/registered_models/{id}` — successful lookup and not-found behavior.
3. `GET /api/model_registry/v1/registered_models/{id}/versions` — nested version list and
   pagination.
4. `GET /api/model_registry/v1/model_versions/{id}` — successful lookup and not-found behavior.
5. One representative unauthorized response, verifying the established `401` error shape.

The provider's generated candidate must match the committed bundled artifact before compatibility
results are accepted.

## Baselines and change policy

- **Rolling baseline:** the immutable merge-base revision of protected `main`; a pull request may
  not change the baseline used to assess itself.
- **Release baseline:** the productization-approved Model Registry revision shipped in the current
  supported RHOAI release. This mapping must be confirmed before enforcement. For report-only
  plumbing, `v0.3.17` (`9245aa85fb1898db850ab959c2dee501e65a1ed0`) is a provisional comparison
  candidate, not a declaration of RHOAI support.
- **Compatible example:** add an optional response field.
- **Seeded breaks:** remove a consumed response field, make a response field required, change a
  consumed field's type, and leave the committed bundle stale after changing its source.
- **Intentional break:** requires a Jira-linked migration or deprecation plan, affected-consumer
  approval, a named owner, and a release/versioning decision.

## Ownership and dates

| Responsibility | Proposed owner |
|---|---|
| Working-group facilitator and decision record | Edson Tirelli |
| Dashboard consumer profile and tests | Anthony Coughlin |
| Model Registry provider changes | One named Model Registry maintainer — confirmation required |
| Supported-release baseline | Rishab Prasad / Radim Kubis — confirmation required |
| First working session | October 2, 2026 — proposed |
| Pilot recommendation | October 16, 2026 — proposed |

## Exit criteria

The pilot succeeds when all seeded breaks are detected, the additive change passes, feedback is
actionable in under five minutes without a cluster, provider and consumer owners can reproduce the
result locally, and at least one real pull request runs without an unexplained false block. The
closeout produces an enforce/continue-reporting decision and a reusable onboarding template.

Approval of this proposal closes the pilot-selection decision. The remaining prerequisites before
implementation are naming the provider maintainer, confirming the supported-release revision, and
accepting or adjusting the proposed dates.
