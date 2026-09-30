#!/usr/bin/env python3
import json, pathlib, re, sys

p=pathlib.Path(sys.argv[1])
d=json.loads(p.read_text(encoding="utf-8"))
if d.get("schema") != 1: raise SystemExit("unsupported guest-job schema")
if not re.fullmatch(r"[A-Za-z0-9._-]+", d.get("id","")): raise SystemExit("invalid job id")
if not isinstance(d.get("command"),str) or not d["command"]: raise SystemExit("missing command")
args=d.get("arguments",[])
if not isinstance(args,list) or not all(isinstance(x,str) for x in args): raise SystemExit("arguments must be strings")
assigns=d.get("assigns",{})
if not isinstance(assigns,dict): raise SystemExit("assigns must be an object")
for k,v in assigns.items():
    if not re.fullmatch(r"[A-Za-z][A-Za-z0-9_]*:",k): raise SystemExit("invalid assign")
    if not isinstance(v,str) or not v: raise SystemExit("invalid assign target")
arts=d.get("expected_artifacts",[])
if not isinstance(arts,list): raise SystemExit("expected_artifacts must be a list")
for rel in arts:
    q=pathlib.PurePosixPath(rel)
    if q.is_absolute() or ".." in q.parts: raise SystemExit("unsafe artifact path")
if not isinstance(d.get("expected_exit",0),int): raise SystemExit("expected_exit must be integer")
print("guest-job contract: PASS")
