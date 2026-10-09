# Decision Log

Current scope and planning follow the [one-page stakeholder brief](../docs/stakeholder-brief.md).
Superseded rows retain the history; they do not define the current pilot.

| ID | Date | State | Decision | Rationale / follow-up |
|---|---|---|---|---|
| D-001 | 2026-09-25 | Accepted | Canonical contracts stay with provider implementations; central governance remains pointer-only. | Avoids specification drift and preserves provider ownership. |
| D-002 | 2026-09-25 | Accepted | Enforcement has three layers: provider PR check, reviewed intentional-break path, and release conformance. | Moves common failures earlier without making Dashboard E2E the provider gate. |
| D-003 | 2026-09-30 | Superseded | Use Model Registry REST v1 consumed by Dashboard as the first executable pilot. | Replaced by the Model Catalog scope in the authoritative stakeholder brief; see D-008. |
| D-004 | 2026-09-30 | Proposed | Keep `opendatahub-operator` and `workbenches-operator` in the follow-on cohort rather than implementing three providers at once. | Protects the two-week timebox and proves the framework before expanding contract types. |
| D-005 | 2026-09-30 | Proposed | Use pinned `oasdiff` in report-only mode for the first provider gate. | Provides fast static feedback while policy and false positives are calibrated. |
| D-006 | 2026-09-30 | Superseded | Select the supported-release Model Registry revision. | Registry baselines are not assumed valid for the Catalog pilot; see D-010. |
| D-007 | 2026-09-30 | Pending | Define the exact meaning of `!MaaS` for broader V1 scope. | Follow-on scope clarification; not a prerequisite for the first Catalog pilot. |
| D-008 | 2026-10-01 | Proposed | Use Model Catalog REST v1 consumed by the Dashboard Model Catalog BFF as the first executable pilot, October 5–16. | Current source brief names Edson Tirelli for the provider and facilitation, Anthony Coughlin for Dashboard, and Rishab Prasad / Radim Kubis for the baseline. Pilot approval and dates remain pending. |
| D-009 | 2026-10-01 | Accepted | Treat `docs/stakeholder-brief.md` as the source of truth for current scope, representatives, proposed dates, and success criteria. | User instruction; detailed plans and rendered documents must follow the brief. |
| D-010 | 2026-10-01 | Pending | Select the supported-release Model Catalog revision and confirm the Dashboard-consumed wire API version. | Productization confirms the immutable release baseline; provider/consumer representatives confirm the concrete Catalog contract. |
| D-011 | 2026-10-09 | Proposed | Resolve baselines as immutable provider revisions and content digests recorded in the working-group pointer catalog. | A pull request must not be able to move or overwrite the baseline used to assess itself; no baseline schema copy is added to the provider repository. |
| D-012 | 2026-10-09 | Proposed | Pin every required compatibility tool, policy, module, and reusable workflow to an exact version or full commit SHA. | Reproducibility and supply-chain control rule out `main`, `latest`, `@latest`, and moving tags as required inputs. |
| D-013 | 2026-10-09 | Proposed | Make consumer-profile verification schema-aware and require coverage of operations, parameters, response fields, and status codes. | Path-existence checks cannot detect removed or narrowed consumer reliance, which is a primary goal of the pilot. |

## Recording a decision

Add one row with a stable ID, date, state, concise decision, rationale, and any approval or follow-up
needed. Change the state rather than deleting superseded or rejected proposals.
