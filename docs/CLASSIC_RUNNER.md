# Classic AmigaOS self-hosted runner

This runner is the private qualification boundary for tests that require legally supplied Kickstart and AmigaOS files.

## Labels

Configure the GitHub Actions runner with both:

- `self-hosted`
- `amiga-classic`

Do not place ROMs or AmigaOS files in the repository or GitHub Actions artifacts.

## Host layout

Recommended private host paths:

```
/opt/amiga-qualification/
  kickstart/
    kick204.rom
    kick30.rom
  systems/
    os204/
    os2/
    os3/
  payload/
```

The runner account and Docker daemon must be able to read these paths. Keep them outside the checked-out repository.

## Repository secrets

The workflow uses path-valued secrets, not ROM contents.

For an A500/AmigaOS 2.04 qualification, for example:

```
AMIGA_RUNTIME_KICKSTART_ROM=/opt/amiga-qualification/kickstart/kick204.rom
AMIGA_RUNTIME_SYSTEM_DIR=/opt/amiga-qualification/systems/os204
```

Never store a ROM image or AmigaOS archive directly in a GitHub secret.

## AmTLS M3.3

Stage the AmTLS artifact on the runner so that the directory contains:

```
amiga-runtime.json
Libs/amtls.library
C/test_m3_3_openclose
S/run-test
```

Then dispatch `Classic AmigaOS qualification` with:

- payload path: the private staged payload directory
- profile: `a500-os204`

A successful run must produce `classic-evidence/result.json` with `runtime=amigaos`, `emulator=fs-uae`, and `status=PASS`.

## Security boundary

The classic runner should be dedicated to trusted Ploos-AS repositories/workflows. Do not expose it to arbitrary pull-request code. Keep proprietary media read-only and outside the Actions workspace.
