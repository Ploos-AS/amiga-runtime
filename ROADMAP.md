# Roadmap

## M0 — Foundation

- [x] Define redistributable runtime/qualification scope
- [x] Define `/work/input` and `/work/evidence` contract
- [x] Establish qualification levels Q0-Q5
- [x] Add container skeleton
- [x] Add runtime CLI skeleton
- [x] Add initial machine profiles
- [x] Add host smoke checks and CI
- [x] Document proprietary-file boundary

## M1 — AROS/m68k runtime

- [x] Pin and verify a redistributable AROS **m68k** runtime source/artifact
- [x] Reject i386/x86 AROS artifacts for Amiga qualification
- [x] Automate AROS/m68k boot under FS-UAE
- [ ] Provide an m68k ARexx-compatible qualification environment
- [ ] Run an m68k ARexx smoke test inside the guest
- [ ] Inject test payload without modifying source artifacts
- [ ] Capture console/serial output
- [x] Enforce boot timeout\n- [ ] Enforce guest execution timeout
- [ ] Emit PASS/FAIL JSON and JUnit evidence
- [x] Qualify the AROS/m68k FS-UAE boot gate on GitHub Actions\n- [ ] Qualify m68k ARexx guest execution on GitHub Actions

### Q3 core infrastructure gate

- [x] Qualify redistributable AROS/m68k boot with FS-UAE
- [x] Qualify redistributable AROS/m68k boot with Amiberry
- [x] Emit an aggregate machine-readable Q3 core result
- [x] Keep ARexx qualification optional and non-blocking for core infrastructure
- [x] Enforce the Q3 core gate on GitHub Actions

**Status:** Q3 core emulator/runtime infrastructure is qualified. ARexx remains a separate optional guest-capability qualification and does not block projects from consuming `amiga-runtime`.

## M2 — Project integration

- [ ] Reusable GitHub Actions workflow
- [ ] Artifact handoff from `amiga-dev`
- [ ] Standard project manifest
- [ ] Standard m68k ARexx qualification contract for projects that expose ARexx
- [ ] ARexx-driven test hooks where available
- [ ] Screenshot/evidence collection

## M3 — External AmigaOS backend

- [ ] User-supplied ROM/OS mount contract
- [ ] Never redistribute proprietary ROM/OS material
- [ ] AmigaOS 2.04 profile
- [ ] AmigaOS 3.x profiles
- [ ] Run the same m68k ARexx qualification payload used by the free runtime where compatible
- [ ] Local qualification workflow

## M4 — Multi-emulator qualification matrix

**Backend policy:** `amiga-runtime` must support multiple independent Amiga emulators. FS-UAE remains the reference backend; Amiberry and FellowNG are first-class backend targets. A backend may be marked `experimental` until it provides deterministic automated execution, but it must use the same runtime/profile/evidence contract.

- [x] Define emulator-neutral backend contract
- [x] Keep FS-UAE as the first/reference backend
- [x] Add Amiberry backend
- [x] Add `--emulator fs-uae|amiberry|fellowng` selection
- [x] Add `compare --emulators ...` qualification mode
- [ ] Run identical **m68k** runtime, machine profile, ARexx test and payload across selected emulators
- [ ] Require m68k ARexx qualification on each supported emulator backend
  - [ ] Build/package AROS contrib Regina + RexxMast for the redistributable amiga-m68k CI guest (upstream AROS #866)
  - [ ] Run the same `runtime/arexx/smoke.rexx` through Regina/RexxMast on FS-UAE, Amiberry and FellowNG
- [ ] Never substitute AROS/i386 qualification for an Amiga/m68k emulator qualification
- [x] Classify differing results as `EMULATOR_DIVERGENCE`
- [ ] Preserve per-emulator logs, screenshots, serial output, ARexx output, JSON and JUnit evidence
  - [x] Preserve per-emulator evidence directories and machine-readable backend JSON in compare mode
- [x] Add FellowNG backend adapter and integration tests
- [x] Build/use FellowNG portable CLI path with deterministic `fellowng.runtime-result.v1` qualification
- [x] Keep FellowNG backend explicitly `experimental` until deterministic automated qualification is available — deterministic CI qualification is now available
- [ ] Keep FellowNG experimental until its regression suite is sufficiently mature
- [ ] Feed reproducible FS-UAE/Amiberry/FellowNG divergences into FellowNG regression tests
- [ ] A500 / 68000
- [ ] A500+ / 68000
- [x] A1200 / 68020 — FellowNG AROS/m68k deterministic CI baseline
- [ ] A1200 / 68030
- [ ] A4000-class profile

## M5 — LibreKick/free-runtime integration

- [ ] LibreKick backend when sufficiently bootable
- [ ] Preserve the m68k ARexx qualification contract when the free runtime supports it
- [ ] Cross-project compatibility matrix
- [ ] Regression qualification suite
