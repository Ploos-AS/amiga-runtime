# AROS runtime backend

M1 turns the M0 contract into a reproducible AROS/m68k runtime backend.

The container deliberately does **not** embed proprietary Amiga Kickstart or Workbench material. The AROS boot artifact is supplied as a redistributable artifact and verified against a pinned SHA-256 before use.

## Artifact contract

Set either:

- `AROS_BOOT_IMAGE=/path/to/aros.adf`, or
- `AROS_BOOT_URL` plus `AROS_BOOT_SHA256` to let `prepare-aros` fetch and verify it.

The resulting image is stored in `/opt/amiga-runtime/aros/aros.adf` by default.

M1.0 provides deterministic acquisition, validation, evidence/result generation, timeout handling and an emulator invocation harness. The next qualification step pins the chosen upstream AROS m68k artifact and validates its actual boot markers on GitHub Actions.
