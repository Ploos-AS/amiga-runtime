# m68k ARexx qualification contract

The runtime qualification is deliberately emulator-neutral.

A backend may claim the ARexx gate only when an **m68k guest** executes
`runtime/arexx/smoke.rexx` through an ARexx-compatible interpreter and the
guest emits the exact token `AMIGA_RUNTIME_AREXX_OK`.

An emulator merely remaining alive, an x86/i386 AROS process, or a host-side
script must never satisfy this gate.

Evidence must preserve the emulator name, runtime identity, guest architecture,
ARexx output, exit/result state, and the smoke token. The same payload is used
for FS-UAE, Amiberry and later FellowNG so differing results can be classified
as emulator divergence.

The AROS/m68k boot-ISO gate is intentionally separate. It proves the
redistributable runtime boots; it does not by itself prove ARexx execution.

## Redistributable AROS/Regina path

The upstream AROS contrib tree already defines the pieces required for a
redistributable m68k ARexx guest:

- `contrib-regina-module` builds `regina.library` from the Regina shared module.
- `contrib-regina-rexxmast-arosc` builds `C:RexxMast` and links it against
  `regina_shared` and `rexxsyslib`.
- The main AROS tree supplies `rexxsyslib.library`, `RX`, and Startup-Sequence
  logic that starts `C:RexxMast` when present.

The current amiga-m68k nightly/contrib artifact does not package the complete
Regina/RexxMast set (tracked upstream as AROS #866). Therefore public CI must
not claim an ARexx PASS until these redistributable m68k components are built
or obtained from an upstream artifact and injected into the prepared guest.

The intended CI guest remains AROS/m68k; proprietary AmigaOS or Kickstart
assets are not required for this qualification path.
