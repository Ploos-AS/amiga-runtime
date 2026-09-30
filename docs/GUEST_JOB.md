# Guest job contract

A guest job is a declarative request to execute a command inside an Amiga guest and collect evidence.

It is intended for compilers, assemblers, converters, test utilities and other tools that must run in the guest.

## Schema 1

Example:

```json
{
  "schema": 1,
  "id": "example",
  "command": "Tool",
  "arguments": ["input"],
  "assigns": {"DATA:": "Work:data"},
  "expected_artifacts": ["output"],
  "expected_exit": 0
}
```

Rules:

- command and arguments are guest command tokens, not a host shell string
- assign names must end in `:`
- artifact paths are relative and may not contain `..`
- the host validates the manifest before any guest execution
- guest stdout, guest return code and produced artifacts form the evidence
- emulator launch success alone is not job success
- proprietary assets are not part of the job manifest

The initial implementation provides validation and a stable contract. Backend execution is added per runtime without changing consumers.
