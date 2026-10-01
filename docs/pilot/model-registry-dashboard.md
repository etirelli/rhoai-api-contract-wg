# Model Catalog–Dashboard API Contract Pilot

- **Status:** Proposed; awaiting pilot approval
- **Source of truth:** [One-page stakeholder brief](../stakeholder-brief.md)
- **Tracking:** [RHOAIENG-96904](https://redhat.atlassian.net/browse/RHOAIENG-96904)
- **Updated:** October 1, 2026
- **Proposed execution:** October 5–16, 2026
- **Proposed recommendation date:** October 16, 2026

## Decision

Make the first executable two-week slice one provider/consumer seam: the **Model Catalog REST
v1 API consumed by the Dashboard Model Catalog BFF**. This document elaborates the stakeholder
brief; pilot approval and acceptance of the proposed dates remain pending.

The broader cohort includes `opendatahub-operator` and `workbenches-operator`, with Dashboard as
a consumer. Operator/CRD checks and a multi-component release matrix are follow-on work, rather
than deliverables of this first slice. Other interfaces require a separate scope decision.

## Why this pilot

The Dashboard gap analysis found no consumer-facing contract tests in the ten assessed upstream
repositories, while Dashboard frequently discovered provider failures late. The Model Catalog
seam provides a bounded proof of earlier compatibility feedback for a service used by Dashboard.

The pilot combines a report-only OpenAPI comparison with provider-facing consumer coverage.
Existing Dashboard tests may provide scaffolding, but tests of a BFF response alone do not prove
the provider REST contract. The consumer profile must name the actual Model Catalog operations
and behavior Dashboard relies on.

## Contract boundary

| Item | Pilot definition |
|---|---|
| Provider | Model Catalog service in [`opendatahub-io/model-registry`](https://github.com/opendatahub-io/model-registry/tree/main/catalog); proposed representative: Edson Tirelli |
| Canonical source | Provider-owned Model Catalog OpenAPI source; exact source paths and consumed revision to confirm |
| Generated candidate | Fresh Catalog contract from the pull-request source, using a pinned generation/bundling target; declared output path to confirm |
| Consumer | Dashboard Model Catalog BFF; proposed representative: Anthony Coughlin |
| Consumer tests | Provider-facing Catalog profile; exact Dashboard client and test paths to confirm |
| Provider check | Pinned OpenAPI compatibility check, initially report-only; `oasdiff` remains the proposed tool |
| Runtime evidence | Bounded provider behavior checks for the consumer profile, reproducible without a cluster |

The first consumer profile covers the model/version list and lookup behavior named in the brief,
including pagination, empty results, not-found, and authorization behavior. Provider and consumer
representatives must map those interactions to the actual Catalog operations, response fields,
status codes, and fixtures before implementation. Model Registry endpoints and fixtures must not
be reused as if they described the Catalog contract.

**Version confirmation:** the stakeholder scope is Model Catalog REST v1. The
[provider's Catalog README](https://github.com/opendatahub-io/model-registry/tree/main/catalog)
currently documents a `/api/model_catalog/v1alpha1` base path. The exact Dashboard-consumed
revision and wire API version must therefore be confirmed; this reference does not change the
stakeholder scope or declare a support level.

The generated candidate must match any declared committed bundled artifact before compatibility
results are accepted. Schema comparison alone does not prove runtime semantics.

## Baselines and change policy

- **Rolling baseline:** an immutable revision or accepted snapshot from the protected provider
  target branch, resolved independently of the pull request. The pull request cannot move the
  baseline used to assess itself.
- **Release baseline:** the productization-approved revision of Model Catalog shipped in the
  supported RHOAI release. Rishab Prasad / Radim Kubis must confirm that mapping. No Registry
  release tag or SHA is presumed to be a valid Catalog baseline.
- **Compatible example:** add an optional response field without changing relied-on behavior.
- **Seeded incompatibilities:** remove a consumed field or operation, change a consumed field's
  type, or introduce an incompatible required input. Also change source without updating the
  committed generated artifact to prove stale-artifact detection.
- **Intentional break:** requires a reviewed migration or deprecation plan, affected-consumer
  approval, a named owner, and a release/versioning decision.

The first integration reports findings. Enforcement follows stable evidence and owner agreement.

## Ownership and proposed delivery

| Responsibility | Proposed representative / commitment |
|---|---|
| Facilitation | Edson Tirelli |
| Consumer profile and tests | Anthony Coughlin / Dashboard |
| Provider implementation and checks | Edson Tirelli / Model Catalog |
| Supported-release baseline | Rishab Prasad / Radim Kubis; confirm provider revision |
| Execution window | October 5–16, 2026 — proposed |
| Scorecard and recommendation | October 16, 2026 — proposed |

**Week 1:** confirm contract details, owners, and baselines; integrate the report-only provider
check and Dashboard consumer profile.

**Week 2:** exercise compatible, breaking, and stale-artifact changes; validate feedback on at least
one real pull request; publish the scorecard and enforce/continue-reporting recommendation.

## Exit criteria

The pilot succeeds when seeded incompatibilities and stale artifacts are detected, an additive
change passes, feedback is actionable in **under five minutes without a cluster**, results are
reproducible locally, and at least one real pull request runs without an unexplained false block.
Deliverables are a scorecard, reusable onboarding template, and an enforce/continue-reporting
recommendation.

Before implementation, approve the pilot, confirm the Catalog contract details and supported-
release revision, and accept or adjust the proposed execution dates. Provider and consumer
representatives are already named in the stakeholder brief; they are not missing-owner blockers.
