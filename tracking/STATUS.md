# Working Group Status

- **Last updated:** 2026-10-01
- **Source of truth:** [One-page stakeholder brief](../docs/stakeholder-brief.md)
- **Phase:** Pilot approval and setup
- **Overall:** Amber — the Model Catalog–Dashboard pilot and proposed representatives are defined;
  approval, Catalog contract details, the release baseline, and execution dates remain open.

## Progress

| Milestone | State | Evidence / next gate |
|---|---|---|
| Working-group charter | Complete | Mission, ownership model, scope, and guardrails documented |
| Dashboard gap analysis | Complete | 132 upstream component bugs classified |
| Target architecture | Complete | Architecture and delivery proposal drafted |
| First pilot definition | Proposed | Model Catalog–Dashboard proposal awaiting approval |
| Pilot representatives | Named (proposed) | Edson Tirelli: provider and facilitator; Anthony Coughlin: Dashboard; Rishab Prasad / Radim Kubis: release baseline |
| Catalog contract boundary | Pending | Confirm OpenAPI source/output, generator, consumed API version, and Dashboard interactions |
| Contract and release baselines | Partial | Protected-branch strategy defined; supported Catalog revision pending |
| Provider report-only gate | Not started | Implement after pilot approval |
| Dashboard consumer profile | Not started | Add provider-facing Model Catalog coverage |
| Seeded compatibility scenarios | Not started | Additive, breaking, and stale-generated-artifact cases |
| Pilot scorecard and recommendation | Not started | Proposed for 2026-10-16 |

## Current blockers

1. The Model Catalog–Dashboard pilot still awaits approval.
2. Catalog source/output paths, generation target, actual consumed API version, and consumer
   interactions must be confirmed before implementing the profile.
3. Productization has not confirmed the immutable Model Catalog revision shipped in the supported
   RHOAI release.
4. The proposed October 5–16 execution window has not been accepted.

Operator/CRD checks and multi-component release conformance are follow-on work. Broader scope
questions, including the charter's `!MaaS` notation, do not block this bounded Catalog pilot.

## Next checkpoint

Approve the [pilot proposal](../docs/pilot/model-registry-dashboard.md), resolve actions A-001
through A-005, and then begin the report-only provider gate.
