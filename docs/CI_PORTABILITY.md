# CI portability requirements

`amiga-runtime` MUST remain independent of any single CI provider.

## Required environments

The runtime image and qualification interface MUST support:

- local Docker or Podman execution;
- GitHub Actions on a compatible container runner;
- Forgejo Actions using a Forgejo Runner with OCI/container execution.

## Stable runtime contract

The portable contract is:

- project/artifact input mounted read-only at `/work/input`;
- generated evidence written to `/work/evidence`;
- primary invocation through `amiga-runtime test <program> [--profile <profile>] [--runtime <runtime>]`.

Core runtime, emulator orchestration, result collection, and evidence generation MUST be implemented in portable scripts/tools, not GitHub-specific workflow logic.

## Self-hosted Forgejo qualification

Forgejo compatibility is specifically intended to support private local qualification that public CI cannot perform. A self-hosted Forgejo Runner MAY inject user-owned Kickstart ROMs, Workbench/AmigaOS installations, keys, emulator configuration, and later access to real Amiga hardware.

None of that proprietary material may be committed to Git, uploaded as public CI artifacts, or embedded in published OCI images. Runtime mounts/secrets MUST be externally supplied.

AROS results MUST remain distinguishable from AmigaOS results, and emulator results MUST remain distinguishable from real-hardware qualification.

## Emulator matrix

The CI-neutral contract applies equally to supported emulator backends such as FS-UAE and Amiberry and to future backends such as FellowNG. Backend-specific implementation details must not leak into project-level CI workflows when avoidable.

## Acceptance criterion

A milestone changing runtime entry points, profiles, emulator orchestration, evidence schema, or qualification commands is not complete until the documented command path remains usable locally, in GitHub Actions, and from a Forgejo Actions runner.
