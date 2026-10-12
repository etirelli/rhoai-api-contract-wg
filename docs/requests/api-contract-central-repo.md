# API Contract Central repository request

- **Status:** Ready to submit
- **Requested by:** Anthony Coughlin
- **Date:** 2026-10-12
- **Target team:** DevOps / platform infrastructure

## Summary

Create the official **`api-contract-central`** repository to host the shared API compatibility
runner, schemas, reusable workflows, policy, and pointer registry for RHOAI provider and consumer
repositories.

The current `rhoai-api-contract-wg` repository is a working-group planning space and temporary
placeholder. The generalized `openapi-compat` module and CLI now exist there, but they need an
official, protected home before provider repositories can depend on them in CI.

## Requested repository

| Item | Request |
|---|---|
| Repository | `api-contract-central` |
| Organization | Confirm with DevOps; architecture examples use `opendatahub-io` |
| Default branch | `main` |
| Initial visibility | Internal/private, unless DevOps recommends otherwise |
| Purpose | Shared API contract checks, schemas, workflows, and pointer registry |

## Required access

Grant **maintain** access to:

- Anthony Coughlin
- Edson Tirelli

Add the API Contract working group as a code owner once the team or group is created. DevOps should
retain repository administration responsibility.

## Initial content to import

Import the current generalized implementation from `rhoai-api-contract-wg` at commit
`293feebf1e780d7ce7b34b1669f5c937fa7b6338`:

- `modules/openapi-compat/`
- `cmd/rhoai-contract/`
- `schemas/contract-set.schema.json`
- `.github/workflows/provider-openapi-check.yml`
- `docs/onboarding/openapi-compat.md`

After import, update repository-relative links and repoint the drafted provider workflow to the new
official repository.

## Required repository settings

- Protect `main`:
  - require pull requests;
  - require at least one approval;
  - require signed commits;
  - require passing CI;
  - forbid direct pushes except repository administrators performing recovery.
- Enable GitHub Actions.
- Enable secret scanning and push protection.
- Enable Dependabot security and version updates.
- Add `CODEOWNERS` for shared modules, schemas, workflows, and policy.
- Add a required CI workflow that runs the module test suite.
- Pin reusable workflows and Actions used by provider repositories to full commit SHAs.

## Acceptance criteria

The request is complete when:

1. The official repository exists with the requested access.
2. The initial import is merged through a protected pull request.
3. Module tests pass in CI.
4. The reusable provider workflow is published from the official repository.
5. Edson's model-registry example is repointed from the placeholder repository to
   `api-contract-central`.
6. The onboarding guide refers only to the official repository.

## Follow-up work after creation

- Onboard a second OpenAPI provider to prove the generalized check is reusable.
- Add the pointer registry and immutable baseline records.
- Resolve the Model Catalog `v1` / Dashboard `v1alpha1` mismatch.
- Begin the CRD compatibility research track.

