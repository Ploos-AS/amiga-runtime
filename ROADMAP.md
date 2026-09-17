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

## M1 — AROS runtime

- [ ] Pin and verify a redistributable AROS m68k runtime source/artifact
- [ ] Automate AROS boot under FS-UAE
- [ ] Inject test payload without modifying source artifacts
- [ ] Capture console/serial output
- [ ] Enforce boot and execution timeouts
- [ ] Emit PASS/FAIL JSON and JUnit evidence
- [ ] Qualify the runtime image on GitHub Actions

## M2 — Project integration

- [ ] Reusable GitHub Actions workflow
- [ ] Artifact handoff from `amiga-dev`
- [ ] Standard project manifest
- [ ] ARexx-driven test hooks where available
- [ ] Screenshot/evidence collection

## M3 — External AmigaOS backend

- [ ] User-supplied ROM/OS mount contract
- [ ] Never redistribute proprietary ROM/OS material
- [ ] AmigaOS 2.04 profile
- [ ] AmigaOS 3.x profiles
- [ ] Local qualification workflow

## M4 — Multi-emulator qualification matrix

- [ ] Define emulator-neutral backend contract
- [ ] Keep FS-UAE as the first/reference backend
- [ ] Add Amiberry backend
- [ ] Add `--emulator fs-uae|amiberry|fellowng` selection
- [ ] Add `compare --emulators ...` qualification mode
- [ ] Run identical runtime, machine profile and payload across selected emulators
- [ ] Classify differing results as `EMULATOR_DIVERGENCE`
- [ ] Preserve per-emulator logs, screenshots, serial output, JSON and JUnit evidence
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
- [ ] Cross-project compatibility matrix
- [ ] Regression qualification suite
