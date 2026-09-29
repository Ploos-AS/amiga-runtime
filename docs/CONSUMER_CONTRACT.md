# Consumer contract

Consumer projects use the published `ghcr.io/ploos-as/amiga-runtime` OCI image through documented commands rather than internal image paths.

For reproducible qualification, pin an immutable digest or `sha-*` image tag. `edge` is for integration only.

The standard project handoff is:

1. Q1 artifact produced by `amiga-dev`.
2. Stage artifact plus `amiga-runtime.json`.
3. Mount the staged payload read-only at `/work/input`.
4. Mount an empty writable evidence directory at `/work/evidence`.
5. Invoke `amiga-runtime qualify-contract /work/input`.
6. Preserve machine-readable evidence.

A successful container start or emulator boot is not a project runtime PASS. Required guest evidence from the project contract must be present.

Proprietary Kickstart, Workbench/AmigaOS media and license keys remain outside the redistributable image and repository.
