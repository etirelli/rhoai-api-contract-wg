# rhoai-contract (local runner, placeholder)

A thin CLI over the [`openapi-compat`](../../modules/openapi-compat/) module.
Today this is a Python script, not the signed Go binary the
[architecture proposal](../../docs/architecture/proposal.md) describes as
the eventual local runner (`cmd/rhoai-contract/` in that proposal's modular
layout) — this is the pilot-stage implementation of that same interface,
kept intentionally simple until a second contract type (protobuf, CRD)
justifies a compiled runner.

```bash
python3 cmd/rhoai-contract/cli.py check \
  --repo /path/to/provider/checkout \
  --contract-set .rhoai/contracts.yaml \
  --baseline-ref <full-git-sha> \
  --output-dir /tmp/contract-report \
  [--contract-id <id>] [--enforce] [--oasdiff <path>] [--yq <path>]
```

The same command runs locally and in CI — there is no separate "CI mode" —
so a result is always reproducible without a cluster. See
[`docs/onboarding/openapi-compat.md`](../../docs/onboarding/openapi-compat.md).

Only `openapi` contracts are implemented. `protobuf-compat`, `crd-compat`,
and the other modules in the proposal's target layout are follow-on work.
