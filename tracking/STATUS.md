# Working Group Status

- **Last updated:** 2026-09-30
- **Phase:** Pilot approval and setup
- **Overall:** Amber — the technical direction is ready; ownership and release-baseline decisions are
  still open.

## Progress

| Milestone | State | Evidence / next gate |
|---|---|---|
| Working-group charter | Complete | Mission, ownership model, scope, and guardrails documented |
| Dashboard gap analysis | Complete | 132 upstream component bugs classified |
| Target architecture | Complete | Architecture and delivery proposal drafted |
| First pilot definition | Proposed | Model Registry–Dashboard proposal awaiting approval |
| Provider and productization owners | Pending | Named representatives must confirm participation |
| Contract and release baselines | Partial | Rolling baseline defined; supported-release revision pending |
| Provider report-only gate | Not started | Implement after pilot approval |
| Dashboard consumer profile | Not started | Extend existing contract-test framework |
| Seeded compatibility scenarios | Not started | Additive, breaking, and stale-generated-artifact cases |
| Pilot scorecard and recommendation | Not started | Proposed for 2026-10-16 |

## Current blockers

1. A Model Registry maintainer has not been confirmed as provider DRI.
2. Productization has not confirmed the immutable Model Registry revision shipped in the supported
   RHOAI release.
3. The proposed working session and recommendation dates have not been accepted.
4. The charter's `!MaaS` notation needs an explicit scope statement.

## Next checkpoint

Approve the [pilot proposal](../docs/pilot/model-registry-dashboard.md), resolve actions A-001
through A-005, and then begin the report-only provider gate.
