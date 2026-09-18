# Emulator backend contract

All emulator backends in `amiga-runtime` implement the same logical contract.

## Backend IDs

- `fs-uae` — reference backend; currently qualified.
- `amiberry` — first-class target; adapter pending.
- `fellowng` — first-class independent-lineage target; experimental until FellowNG exposes deterministic portable CLI automation.

## Required operations

A backend must eventually provide:

1. `probe` — report executable/version/capabilities.
2. `run` — execute a machine profile and runtime payload.
3. `qualify` — execute the standard qualification payload and emit evidence.
4. `stop` — terminate deterministically on completion/timeout.

## Common inputs

- machine profile
- runtime image/system tree
- optional user-supplied ROM/OS assets
- read-only project payload under `/work/input`
- writable evidence directory under `/work/evidence`

## Common evidence

Every backend qualification must identify:

- backend ID and emulator version
- guest architecture
- machine profile
- runtime identity
- start/end/result state
- timeout state
- stdout/stderr or equivalent emulator logs
- guest evidence when available

ARexx is an optional guest capability and is **not** required for core emulator/runtime qualification.

## Comparison

The same profile/runtime/payload should be reusable across FS-UAE, Amiberry and FellowNG. A differing result is recorded as `EMULATOR_DIVERGENCE`; it must not be silently normalized.

FellowNG remains experimental until its portable runtime reaches deterministic CLI/automation support, but the backend contract is reserved now so projects do not become coupled to UAE-specific behavior.
