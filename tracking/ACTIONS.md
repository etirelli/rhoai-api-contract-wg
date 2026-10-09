# Action Register

Update this table when ownership, due dates, or state changes. Proposed owners are not commitments
until the named person confirms them. Current representatives and scope follow the
[one-page stakeholder brief](../docs/stakeholder-brief.md).

| ID | Action | Proposed owner | Target | State |
|---|---|---|---|---|
| A-001 | Link the authoritative brief and Model Catalog pilot from RHOAIENG-96904 and request approval | Edson Tirelli | 2026-10-01 | Overdue; approval not yet granted |
| A-002 | Confirm Catalog OpenAPI paths, generation target, consumed wire API version, and consumer operations | Edson Tirelli / Anthony Coughlin | Before proposed October 5 start | Open |
| A-003 | Agree provider/consumer execution responsibilities using the named representatives | Edson Tirelli / Anthony Coughlin | Before proposed October 5 start | Open |
| A-004 | Confirm the supported RHOAI Model Catalog revision used as release baseline | Rishab Prasad / Radim Kubis | Before proposed October 5 start | Open |
| A-005 | Accept or adjust the proposed October 5–16 pilot window | Working group | Before proposed October 5 start | Open |
| A-006 | Implement the pinned, report-only Model Catalog OpenAPI compatibility check | Edson Tirelli / Model Catalog | Week 1 | Awaiting approval and A-002/A-004 |
| A-007 | Add provider-facing Catalog list/lookup, pagination, not-found, and authorization coverage | Anthony Coughlin / Dashboard | Week 1 | Awaiting approval and A-002/A-003 |
| A-008 | Run compatible, breaking, and stale-artifact scenarios and validate at least one real PR | Edson Tirelli / Anthony Coughlin | Week 2 | Not started |
| A-009 | Publish scorecard and enforce/continue-reporting recommendation | Edson Tirelli | 2026-10-16 | Not started |
| A-010 | Clarify `!MaaS` for broader follow-on scope | Working group | Follow-on planning | Open; does not block first pilot |
| A-011 | Resolve the provider `v1` / Dashboard `v1alpha1` wire-version mismatch and confirm the exact consumed boundary | Edson Tirelli / Anthony Coughlin | Before implementation | Open; blocks A-006 and A-007 |
| A-012 | Register rolling and supported-release baselines as full provider SHAs with artifact digests; do not add a mutable baseline copy | Edson Tirelli / Rishab Prasad / Radim Kubis | Before implementation | Open; blocks A-006 |
| A-013 | Select and pin exact contract tool, policy, and reusable-workflow revisions; reject `main`, `latest`, and `@latest` inputs (re-evaluates the superseded `oasdiff` pick in D-005) | Edson Tirelli / API Contract testing infrastructure | Before implementation | Open; blocks A-006 |
| A-014 | Implement schema-aware consumer-profile verification covering operations, parameters, response fields, and status codes | Anthony Coughlin / Dashboard | Before seeded scenarios | Open; blocks A-008 |
