#!/bin/sh
set -eu
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/good/Libs" "$tmp/good/C" "$tmp/good/S" "$tmp/good/T" "$tmp/bin"
cp "$PWD/tests/contract/bin/backend-fs-uae" "$tmp/bin/backend-fs-uae"
chmod +x "$tmp/bin/backend-fs-uae"
: >"$tmp/good/Libs/demo.library"
: >"$tmp/good/C/test-a"
: >"$tmp/good/C/test-b"
: >"$tmp/good/S/run-test"
cat >"$tmp/good/amiga-runtime.json" <<'EOF'
{
  "schema": 1,
  "project": "Synthetic",
  "milestone": "contract-ci",
  "architecture": "m68k",
  "cpu": "68000",
  "os": "AmigaOS",
  "emulator_profiles": ["a500-os204"],
  "payload": {
    "library": "Libs/demo.library",
    "programs": ["C/test-a", "C/test-b"],
    "script": "S/run-test"
  },
  "result": {
    "logs": ["T/a.log", "T/b.log"],
    "required_lines": ["RC=0", "SYNTHETIC_PASS"]
  },
  "policy": {
    "roms_in_repository": false,
    "amigaos_files_in_repository": false
  },
  "requirements": {
    "network": true,
    "bsdsocket_library": true
  }
}
EOF
# A valid contract must reach the classic backend. Missing private assets is
# expected here and proves validation/routing completed without proprietary data.
set +e
PATH="$tmp/bin:$PATH" sh bin/qualify-contract "$tmp/good" >/tmp/contract-good.out 2>/tmp/contract-good.err
rc=$?
set -e
printf "good rc=%s\n" "$rc" >&2
test "$rc" -eq 69 || { cat /tmp/contract-good.out >&2; cat /tmp/contract-good.err >&2; exit 1; }
grep -q 'SYNTHETIC_BACKEND_REACHED' /tmp/contract-good.out || { cat /tmp/contract-good.out >&2; cat /tmp/contract-good.err >&2; exit 1; }

cp -R "$tmp/good" "$tmp/traversal"
python3 - "$tmp/traversal/amiga-runtime.json" <<'PY'
import json,sys
p=sys.argv[1]; c=json.load(open(p)); c["payload"]["programs"][1]="../escape"; open(p,"w").write(json.dumps(c))
PY
set +e
PATH="$tmp/bin:$PATH" sh bin/qualify-contract "$tmp/traversal" >/tmp/contract-bad.out 2>/tmp/contract-bad.err
rc=$?
set -e
printf "traversal rc=%s\n" "$rc" >&2
grep -q 'unsafe contract path' /tmp/contract-bad.err || { cat /tmp/contract-bad.out >&2; cat /tmp/contract-bad.err >&2; exit 1; }

cp -R "$tmp/good" "$tmp/no-lines"
python3 - "$tmp/no-lines/amiga-runtime.json" <<'PY'
import json,sys
p=sys.argv[1]; c=json.load(open(p)); c["result"]["required_lines"]=[]; open(p,"w").write(json.dumps(c))
PY
set +e
PATH="$tmp/bin:$PATH" sh bin/qualify-contract "$tmp/no-lines" >/tmp/contract-lines.out 2>/tmp/contract-lines.err
rc=$?
set -e
printf "no-lines rc=%s\n" "$rc" >&2
test "$rc" -ne 0
grep -q 'required_lines' /tmp/contract-lines.err

# Classic backend must fail closed when the emulator process fails even if
# guest logs contain every required marker.
mkdir -p "$tmp/classic/System/S" "$tmp/classic/profiles" "$tmp/classic/evidence"
printf 'EndCLI >NIL:\n' >"$tmp/classic/System/S/Startup-Sequence"
: >"$tmp/classic/kick.rom"
cat >"$tmp/classic/profiles/a500-os204.conf" <<'EOF'
machine=a500
cpu=68000
EOF
cat >"$tmp/bin/fake-fs-uae" <<EOF
#!/bin/sh
mkdir -p "$tmp/classic/evidence/Test/T"
printf 'RC=0\\nSYNTHETIC_PASS\\n' >"$tmp/classic/evidence/Test/T/a.log"
printf 'RC=0\\n' >"$tmp/classic/evidence/Test/T/b.log"
exit 7
EOF
chmod +x "$tmp/bin/fake-fs-uae"
set +e
AMIGA_RUNTIME_PROFILES="$tmp/classic/profiles" \
AMIGA_RUNTIME_EVIDENCE="$tmp/classic/evidence" \
AMIGA_RUNTIME_KICKSTART_ROM="$tmp/classic/kick.rom" \
AMIGA_RUNTIME_SYSTEM_DIR="$tmp/classic/System" \
FS_UAE="$tmp/bin/fake-fs-uae" \
sh backends/fs-uae/qualify-classic-contract "$tmp/good" a500-os204 \
  >"$tmp/classic.out" 2>"$tmp/classic.err"
rc=$?
set -e
printf "classic emulator-failure rc=%s\n" "$rc" >&2
test "$rc" -ne 0
python3 - "$tmp/classic/evidence/result.json" <<'PY'
import json,sys
r=json.load(open(sys.argv[1]))
assert r["emulator_exit_code"] != 0, r
assert r["status"] == "FAIL", r
PY

echo "qualification contract validation: PASS"
