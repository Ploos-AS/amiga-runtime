# Emulator qualification evidence schema v1

All emulator backends that participate in m68k qualification MUST emit
`result.json` in their evidence directory.

## Required fields

| Field | Type | Meaning |
|---|---|---|
| `schema` | integer | Evidence schema version; currently `1`. |
| `qualification_level` | string | Qualification level, currently `Q3` for boot qualification. |
| `runtime` | string | Runtime target, for example `aros-m68k`. |
| `emulator` | string | Backend identifier: `fs-uae`, `amiberry`, or `fellowng`. |
| `profile` | string | amiga-runtime machine/profile identifier. |
| `guest_boot_proven` | boolean | Whether the backend satisfied its deterministic guest-boot proof. |
| `status` | string | Normalized `PASS` or `FAIL`. |
| `proof` | string | Human-readable description of the proof used. |

## Optional common fields

`process_rc`, `emulator_started`, `mode`, and backend-specific evidence MAY be
included. Backend-native machine-readable evidence SHOULD be retained under a
field such as `backend_result` rather than discarded.

The common fields are emulator-neutral. A backend may use a different mechanism
to establish `guest_boot_proven`, but compare mode must not reinterpret a
backend-native PASS as a different runtime or architecture.

## Compare contract

`amiga-runtime compare` preserves one evidence directory per emulator and
embeds each available `result.json` in the aggregate `compare.json`.
Mixed PASS/FAIL results are classified as `EMULATOR_DIVERGENCE`.
