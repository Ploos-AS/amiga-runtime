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
