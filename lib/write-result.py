#!/usr/bin/env python3
import json
import pathlib
import sys
import xml.etree.ElementTree as ET

status, rc, profile, program, evidence = sys.argv[1:]
out = pathlib.Path(evidence)
out.mkdir(parents=True, exist_ok=True)

result = {
    "schema": "amiga-runtime-result-v1",
    "runtime": "aros",
    "profile": profile,
    "program": pathlib.Path(program).name,
    "status": status,
    "emulator_exit_code": int(rc),
}
(out / "result.json").write_text(json.dumps(result, indent=2) + "\n")

suite = ET.Element("testsuite", name="amiga-runtime.aros", tests="1", failures="0" if status == "PASS" else "1")
case = ET.SubElement(suite, "testcase", classname="amiga-runtime", name=f"aros.{profile}")
if status != "PASS":
    failure = ET.SubElement(case, "failure", message=status)
    failure.text = f"FS-UAE exit code: {rc}"
ET.ElementTree(suite).write(out / "junit.xml", encoding="utf-8", xml_declaration=True)
