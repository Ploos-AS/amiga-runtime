# M0 Architecture

## Purpose

`amiga-runtime` is the execution and qualification counterpart to `amiga-dev`. Build tooling belongs in the development image; emulator/runtime execution, evidence capture and qualification belong here.

## Trust and licensing boundary

The public image is built only from redistributable components. Proprietary Kickstart ROMs, Workbench/AmigaOS installations and licensed media are explicitly outside the image. A later AmigaOS backend may consume user-supplied files through mounts.

## Filesystem contract

| Path | Purpose |
| --- | --- |
| `/work/input` | read-only project artifacts under test |
| `/work/evidence` | logs, result JSON, JUnit and screenshots |
| `/opt/amiga-runtime/profiles` | versioned machine profiles |
| `/opt/amiga-runtime/bin` | runtime entry points |

## Runtime API

The stable conceptual command is:

```text
amiga-runtime test PROGRAM --runtime aros --profile a1200-020
```

A test execution ultimately reports at least:

- runtime/backend
- machine profile
- boot status
- program-start status
- test status
- exit/result status
- elapsed time
- evidence paths

M0 provides a CLI/self-test skeleton. M1 connects it to a pinned AROS + FS-UAE execution path.

## Qualification semantics

AROS runtime results are compatibility evidence, not proof that a program passes on Commodore/AmigaOS. Results therefore carry an explicit qualification level and runtime identity.

Q0 host tests -> Q1 m68k build -> Q2 AROS runtime -> Q3 automated emulator integration -> Q4 real AmigaOS -> Q5 real hardware where relevant.

## Profiles

M0 defines representative profiles rather than claiming cycle-exact hardware qualification. Initial profiles are `a500`, `a500plus`, `a1200-020`, `a1200-030`, and `a4000`.

## CI model

GitHub Actions validates repository policy, shell syntax, profile presence, CLI self-test and container build. M1 adds an actual AROS boot smoke test.
