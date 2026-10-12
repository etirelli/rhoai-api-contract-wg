# CRD compatibility research brief

- **Status:** Proposed
- **Owner:** Anthony Coughlin
- **Date:** 2026-10-12
- **Goal:** Define a repeatable, provider-owned CRD compatibility check for RHOAI operators.

## Why now

The OpenAPI compatibility path is now generalized into a reusable module. CRDs are the next major
contract type because Dashboard and other consumers depend on operator APIs whose breaking changes
often appear only during integration or upgrade.

This research should produce a concrete CRD pilot, not a general survey of every Kubernetes tool.

## Scope

### In scope

- CRDs consumed by Dashboard, operators, or other RHOAI components.
- Schema compatibility.
- Served and storage API versions.
- Conversion and deprecation paths.
- Defaulting and validation changes.
- Reconciliation and status behavior that consumers rely on.
- Upgrade behavior for existing stored objects.
- Consumer reliance profiles.

### Out of scope

- Replacing full cluster end-to-end testing.
- Solving every operator at once.
- General Kubernetes conformance.
- Runtime behavior that cannot be represented in a bounded, reproducible provider check.

## Research questions

1. Which CRDs do Dashboard and downstream consumers actually depend on?
2. What compatibility guarantee must each CRD preserve?
3. Which static checks can detect breaking CRD changes at pull-request time?
4. Which runtime checks are required beyond a schema diff?
5. How should consumer reliance on specific fields, conditions, and statuses be represented?
6. How should N-1 upgrade compatibility be proven without requiring a full cluster?

## Compatibility dimensions

| Dimension | What must be checked |
|---|---|
| Schema | Removed or renamed fields, type changes, newly required fields, enum narrowing, default changes, validation tightening |
| API versions | Served-version removal, storage-version changes, deprecation policy, conversion path |
| Semantics | Reconciliation behavior, status conditions, readiness, observed fields consumers depend on |
| Upgrade | Existing stored objects remain valid and convertible; N-1 fixtures continue to work |
| Consumer reliance | Explicit fields, conditions, and statuses Dashboard or other consumers read or write |

## Candidate approaches to evaluate

- **Regeneration and diff:** use `controller-gen` to regenerate CRDs from Go types and compare with
  committed YAML.
- **OLM upgrade checks:** evaluate OLM's existing CRD upgrade validation and determine which
  findings can move earlier into provider CI.
- **Schema validation:** evaluate `kubeconform`, `kubeval`, or equivalent tools for validating CRD
  schemas and example objects.
- **Bounded runtime checks:** use `envtest` for API-server behavior, conversion, admission, and
  reconciliation where practical.
- **Semantic CRD differ:** evaluate existing semantic CRD diff tools; do not assume a specific tool
  name until verified.
- **Go API surface:** consider `go-apidiff` for types consumed as libraries by other repositories.

Each candidate must be pinned to an exact version or commit SHA and produce machine-readable
findings suitable for the central result format.

## Evaluation criteria

A candidate approach is useful only if it:

- detects removed or narrowed consumer reliance;
- detects incompatible schema, version, conversion, and upgrade changes;
- runs in provider CI in under five minutes where possible;
- does not require a full cluster for the common pull-request case;
- can be pinned and made reproducible locally;
- emits structured findings with file, path, field, and severity;
- integrates with the shared central runner and report format.

## Proposed first CRD pilot

Select one high-impact CRD from `opendatahub-operator`, likely a Dashboard-consumed CRD after the
inventory is complete. The pilot should:

1. Regenerate the CRD from pull-request source.
2. Compare it with immutable rolling and supported-release baselines.
3. Load a Dashboard-owned consumer profile listing relied-on fields and conditions.
4. Validate representative objects against the candidate schema.
5. Exercise conversion and upgrade behavior with bounded `envtest` fixtures.
6. Run initially in report-only mode.
7. Seed one compatible change, one breaking schema change, and one conversion or upgrade failure.

## Deliverables

- CRD inventory with owners, consumers, support level, and current test coverage.
- Compatibility matrix by CRD and API version.
- Tool evaluation with pinned versions and limitations.
- Prototype report-only CRD check.
- Recommendation for the first enforceable CRD gate.

## Next steps

1. Inventory CRDs consumed by Dashboard and the follow-on operators.
2. Choose the first CRD pilot with the provider owner.
3. Define the consumer reliance profile.
4. Evaluate the candidate tools against seeded compatible and breaking changes.
5. Implement a report-only prototype in `api-contract-central`.

