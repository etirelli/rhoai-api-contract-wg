# RHOAI API Contract Initiative

Stakeholder brief · **Date:** October 9, 2026 · **Status:** in review — re-acceptance required

Move API compatibility feedback into component pull requests so teams can catch integration
failures earlier, with clear ownership and a repeatable path for intentional changes.

## Why this matters

The August 2026 Dashboard gap analysis classified **132 of 194 reviewed issues as upstream
component bugs** and found no consumer-facing contract tests in the ten assessed repositories.
Dashboard integration tests frequently reveal provider failures after components are assembled,
creating rework and release risk. These findings motivate earlier checks; they do not mean every
historical bug would be prevented by contract testing.

## Proposed approach

Provider teams keep canonical API definitions and behavior tests beside their implementation. Consumers, including Dashboard, record the operations and behavior they depend on. The API Contract testing infra supplies shared compatibility policy, reusable CI checks, and a catalog pointing to these artifacts.

Each provider pull request generates a fresh contract, checks that committed artifacts are
current, and compares against protected branch and supported-release baselines. Consumer
expectations and provider behavior tests cover semantics that schema comparisons cannot prove.
Checks begin in report-only mode; enforcement follows evidence and owner agreement. Intentional
breaks require a reviewed migration or deprecation plan and affected-consumer approval.
Cross-component release conformance is part of the longer-term model.

## First pilot: Model Catalog → Dashboard

The proposed **October 5–16, 2026** pilot covers the Model Catalog REST v1 API used by the
Dashboard Model Catalog BFF. An October 9 upstream review found the Dashboard BFF currently
targets `v1alpha1` while the provider ships `v1` Catalog paths; this mismatch must be resolved
before implementation, so the execution window requires re-acceptance. Once re-accepted, the pilot
adds a report-only OpenAPI compatibility check and provider-facing consumer coverage for
model/version list and lookup, pagination, not-found, and authorization behavior.

**Week 1:** confirm owners and baselines; integrate the provider check and consumer profile.

**Week 2:** exercise compatible, breaking, and stale-artifact changes; publish a scorecard and
recommend whether to enforce or continue reporting.

Operator/CRD checks and a multi-component release matrix are follow-on work. The broader cohort
includes `opendatahub-operator` and `workbenches-operator`.

## Ownership and stakeholder support

| Responsibility | Proposed representative / commitment |
| :--- | :--- |
| Facilitation | Edson Tirelli |
| Consumer profile and tests | Anthony Coughlin / Dashboard |
| Provider implementation and checks | Edson Tirelli / Model Catalog |
| Supported-release baseline | Rishab Prasad / Radim Kubis; confirm provider revision |

## Success and decision requested

Success means seeded incompatibilities and stale artifacts are detected, an additive change
passes, feedback arrives in **under five minutes without a cluster**, results are reproducible
locally, and at least one real pull request runs without an unexplained false block. Deliverables
are a scorecard, reusable onboarding template, and an enforce/continue-reporting recommendation.

**Tracking:** [RHOAIENG-96904](https://redhat.atlassian.net/browse/RHOAIENG-96904) ·
**Basis:** [Architecture proposal](architecture/proposal.md),
[pilot definition](pilot/model-registry-dashboard.md), and
[gap analysis](research/dashboard-integration-gap-analysis.html).
