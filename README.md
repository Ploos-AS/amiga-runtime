# amiga-runtime

Containerized Amiga runtime test environment for Ploos-AS projects.

## M0 goals

M0 establishes the runtime contract and repository skeleton for repeatable Amiga-family runtime qualification in CI and locally.

Initial scope:

- Linux container image suitable for CI runners
- AROS as the redistributable runtime baseline
- FS-UAE integration point for emulated execution
- standard runtime profiles
- smoke-test harness
- machine-readable evidence/results layout
- no proprietary Kickstart or AmigaOS files in the repository or image

## Runtime contract

A project under test is mounted read-only at `/work/input`. Runtime evidence is written to `/work/evidence`.

The primary entry point is:

```sh
amiga-runtime test <program> [--profile <profile>] [--runtime <runtime>]
```

M0 implements the contract skeleton and self-tests. Full AROS boot automation lands in M1.

## Qualification levels

- Q0: host tests
- Q1: m68k cross-build
- Q2: AROS runtime
- Q3: automated emulator/runtime integration
- Q4: real AmigaOS qualification
- Q5: real hardware qualification, where applicable

AROS qualification must never be reported as equivalent to AmigaOS qualification.

## Repository policy

This repository must remain redistributable. Do not commit or bake proprietary Kickstart ROMs, Workbench/AmigaOS media, keys, or licensed system files into the image.

See [ROADMAP.md](ROADMAP.md) and [docs/M0_ARCHITECTURE.md](docs/M0_ARCHITECTURE.md).
