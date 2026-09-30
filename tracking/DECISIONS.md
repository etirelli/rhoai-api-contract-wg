# Decision Log

| ID | Date | State | Decision | Rationale / follow-up |
|---|---|---|---|---|
| D-001 | 2026-09-25 | Accepted | Canonical contracts stay with provider implementations; central governance remains pointer-only. | Avoids specification drift and preserves provider ownership. |
| D-002 | 2026-09-25 | Accepted | Enforcement has three layers: provider PR check, reviewed intentional-break path, and release conformance. | Moves common failures earlier without making Dashboard E2E the provider gate. |
| D-003 | 2026-09-30 | Proposed | Use Model Registry REST v1 consumed by Dashboard as the first executable pilot. | Existing OpenAPI and Dashboard BFF code provide the narrowest useful proof. Approve in RHOAIENG-96904. |
| D-004 | 2026-09-30 | Proposed | Keep `opendatahub-operator` and `workbenches-operator` in the follow-on cohort rather than implementing three providers at once. | Protects the two-week timebox and proves the framework before expanding contract types. |
| D-005 | 2026-09-30 | Proposed | Use pinned `oasdiff` in report-only mode for the first provider gate. | Provides fast static feedback while policy and false positives are calibrated. |
| D-006 | 2026-09-30 | Pending | Select the supported-release Model Registry revision. | Productization must map the supported RHOAI release to an immutable provider SHA. |
| D-007 | 2026-09-30 | Pending | Define the exact meaning of `!MaaS` for V1. | Required before publishing final V1 scope. |

## Recording a decision

Add one row with a stable ID, date, state, concise decision, rationale, and any approval or follow-up
needed. Change the state rather than deleting superseded or rejected proposals.
