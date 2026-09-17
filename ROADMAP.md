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

- [ ] Pin and verify a redistributable AROS **m68k** runtime source/artifact
- [ ] Reject i386/x86 AROS artifacts for Amiga qualification
- [ ] Automate AROS/m68k boot under FS-UAE
- [ ] Provide an m68k ARexx-compatible qualification environment
- [ ] Run an m68k ARexx smoke test inside the guest
- [ ] Inject test payload without modifying source artifacts
- [ ] Capture console/serial output
- [ ] Enforce boot and execution timeouts
- [ ] Emit PASS/FAIL JSON and JUnit evidence
- [ ] Qualify the runtime image on GitHub Actions

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

- [ ] Define emulator-neutral backend contract
- [ ] Keep FS-UAE as the first/reference backend
- [ ] Add Amiberry backend
- [ ] Add `--emulator fs-uae|amiberry|fellowng` selection
- [ ] Add `compare --emulators ...` qualification mode
- [ ] Run identical **m68k** runtime, machine profile, ARexx test and payload across selected emulators
- [ ] Require m68k ARexx qualification on each supported emulator backend
- [ ] Never substitute AROS/i386 qualification for an Amiga/m68k emulator qualification
- [ ] Classify differing results as `EMULATOR_DIVERGENCE`
- [ ] Preserve per-emulator logs, screenshots, serial output, ARexx output, JSON and JUnit evidence
- [ ] Add FellowNG backend when FellowNG supports deterministic automated qualification
- [ ] Keep FellowNG experimental until its regression suite is sufficiently mature
- [ ] Feed reproducible FS-UAE/Amiberry/FellowNG divergences into FellowNG regression tests
- [ ] A500 / 68000
- [ ] A500+ / 68000
- [ ] A1200 / 68020
- [ ] A1200 / 68030
- [ ] A4000-class profile

## M5 — LibreKick/free-runtime integration

- [ ] LibreKick backend when sufficiently bootable
- [ ] Preserve the m68k ARexx qualification contract when the free runtime supports it
- [ ] Cross-project compatibility matrix
- [ ] Regression qualification suite
