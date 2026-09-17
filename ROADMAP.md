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

## M4 — Expanded emulation matrix

- [ ] A500 / 68000
- [ ] A500+ / 68000
- [ ] A1200 / 68020
- [ ] A1200 / 68030
- [ ] A4000-class profile
- [ ] Additional emulator backend evaluation

## M5 — LibreKick/free-runtime integration

- [ ] LibreKick backend when sufficiently bootable
- [ ] Cross-project compatibility matrix
- [ ] Regression qualification suite
