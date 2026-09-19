#!/usr/bin/env python3
import json
import pathlib
import sys

root = pathlib.Path(sys.argv[1] if len(sys.argv) > 1 else ".")
checks = {
    "fs-uae": root / "runtime-evidence" / "result.json",
    "amiberry": root / "amiberry-runtime-evidence" / "result.json",
}
results = {}
for backend, path in checks.items():
    data = json.loads(path.read_text())
    if data.get("status") != "PASS":
        raise SystemExit(f"{backend}: status is not PASS")
    if data.get("emulator") != backend:
        raise SystemExit(f"{backend}: emulator identity mismatch")
    if data.get("guest_boot_proven") is not True:
        raise SystemExit(f"{backend}: guest boot not proven")
    results[backend] = {
        "status": data["status"],
        "guest_boot_proven": True,
        "profile": data.get("profile"),
        "runtime": data.get("runtime"),
    }

out = {
    "schema": 1,
    "qualification_level": "Q3",
    "gate": "core-emulator-runtime-integration",
    "status": "PASS",
    "guest_architecture": "m68k",
    "runtime": "aros-m68k",
    "backends": results,
    "arexx_required": False,
    "arexx_status": "OPTIONAL_NOT_PART_OF_CORE_GATE",
    "proprietary_rom_required": False,
    "proprietary_os_required": False,
}
outdir = root / "q3-core-evidence"
outdir.mkdir(parents=True, exist_ok=True)
(outdir / "result.json").write_text(json.dumps(out, indent=2) + "\n")
print("amiga-runtime Q3 core qualification: PASS")
