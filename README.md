# RHOAI API Contract Working Group

This repository coordinates the RHOAI API contract working group: decisions, pilot execution,
evidence, and progress toward reusable provider-owned compatibility checks.

## Current status

The work is in **pilot approval and setup**. Analysis and the target architecture are complete. The
first proposed executable slice is the Model Registry REST v1 API consumed by the Dashboard BFF.
Provider ownership, the supported-release baseline, and execution dates still require confirmation.

- [Current status and milestones](tracking/STATUS.md)
- [Open actions](tracking/ACTIONS.md)
- [Decision log](tracking/DECISIONS.md)
- [Model Registry–Dashboard pilot proposal](docs/pilot/model-registry-dashboard.md)
- [Architecture and delivery proposal](docs/architecture/proposal.md)
- [Dashboard integration gap analysis](docs/research/dashboard-integration-gap-analysis.html)

## Working model

- Canonical API contracts and provider checks stay in component repositories.
- Consumers record the behavior they depend on in their repositories.
- This repository tracks shared policy, decisions, pilot evidence, and reusable coordination
  material. It is not a second source of truth for provider specifications.
- Jira [RHOAIENG-96904](https://redhat.atlassian.net/browse/RHOAIENG-96904) is the external tracking
  issue; this repository holds the reviewable working artifacts behind it.

## Repository layout

```text
.
├── README.md
├── docs/
│   ├── README.md
│   ├── architecture/       # Target architecture, diagram, and rendered version
│   ├── pilot/              # Approved or proposed pilot definitions
│   └── research/           # Supporting evidence and gap analysis
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
5. Keep generated presentations under `docs/architecture/rendered/`; edit the Markdown source.
