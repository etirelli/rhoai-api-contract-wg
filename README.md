# RHOAI API Contract Working Group

This repository coordinates the RHOAI API contract working group: decisions, pilot execution,
evidence, and progress toward reusable provider-owned compatibility checks.

## Current status

The work is in **pilot approval and setup**. The first proposed executable slice is the Model
Catalog REST v1 API consumed by the Dashboard Model Catalog BFF, proposed for October 5–16, 2026.
Edson Tirelli is the proposed provider representative and facilitator; Anthony Coughlin represents
Dashboard. The supported-release baseline, Catalog contract details, and execution dates still
require confirmation.

The [one-page stakeholder brief](docs/stakeholder-brief.md) is the source of truth for the current
scope, representatives, proposed dates, and success criteria. The detailed documents elaborate
that brief; the architecture also describes the longer-term operating model.

- [Current status and milestones](tracking/STATUS.md)
- [Open actions](tracking/ACTIONS.md)
- [Decision log](tracking/DECISIONS.md)
- [One-page stakeholder brief](docs/stakeholder-brief.md) ([PDF](docs/stakeholder-brief.pdf))
- [Model Catalog–Dashboard pilot proposal](docs/pilot/model-registry-dashboard.md)
- [Architecture and delivery proposal](docs/architecture/proposal.md)
- [Dashboard integration gap analysis](docs/research/dashboard-integration-gap-analysis.html)

## Working model

- Canonical API contracts and provider checks stay in component repositories.
- Consumers record the behavior they depend on in their repositories.
- API Contract testing infrastructure supplies shared compatibility policy, reusable CI checks,
  and a pointer catalog; the working group coordinates governance and adoption.
- This repository tracks shared policy, decisions, pilot evidence, and reusable coordination
  material. It is not a second source of truth for provider specifications.
- Jira [RHOAIENG-96904](https://redhat.atlassian.net/browse/RHOAIENG-96904) is the external tracking
  issue; this repository holds the reviewable working artifacts behind it.

## Repository layout

This repository also serves as a **placeholder for `api-contract-central`**
until that repository is created (see `tracking/DECISIONS.md`, D-014): the
reusable checking engine and its onboarding material live here at the paths
a real `api-contract-central` would use, so provider repos can adopt it now
and repoint to the official repository later with minimal change.

```text
.
├── README.md
├── docs/
│   ├── README.md
│   ├── architecture/       # Target architecture, diagram, and rendered version
│   ├── onboarding/         # Provider onboarding guides for central modules
│   ├── pilot/              # Approved or proposed pilot definitions
│   └── research/           # Supporting evidence and gap analysis
├── modules/
│   └── openapi-compat/     # Provider-agnostic OpenAPI compatibility engine
├── schemas/                # Provider ContractSet descriptor schema
├── cmd/rhoai-contract/     # Local/CI runner CLI over the modules above
├── .github/workflows/      # Draft reusable workflow (not yet wired to live CI)
└── tracking/
    ├── STATUS.md           # Phase, milestone, risk, and blocker summary
    ├── ACTIONS.md          # Named and dated follow-up work
    └── DECISIONS.md        # Accepted and pending decisions
```

## Coordination routine

1. Update `tracking/ACTIONS.md` as ownership or due dates change.
2. Record scope or policy choices in `tracking/DECISIONS.md`; do not bury them in meeting notes.
3. Refresh `tracking/STATUS.md` at least weekly and at each pilot milestone.
4. Link material changes from RHOAIENG-96904 so Jira and this repository remain navigable.
5. Update the stakeholder brief first when scope, representatives, dates, or success criteria change;
   reconcile the detailed documents and tracking records, then regenerate the PDF and HTML.
