.PHONY: check container-build

check:
	sh -n bin/amiga-runtime
	sh -n bin/prepare-aros
	sh -n bin/prepare-aros-regina
	sh -n bin/prepare-amiberry
	sh -n bin/prepare-aros-guest-marker
	sh -n bin/run-aros
	sh -n bin/qualify-aros-boot
	sh -n backends/fs-uae/backend
	sh -n backends/amiberry/backend
	sh -n backends/fs-uae/qualify-aros-boot
	sh -n backends/fs-uae/run-aros
	python3 -m py_compile lib/write-result.py lib/generate-fs-uae-config.py
	test -f profiles/a500.conf
	test -f profiles/a500plus.conf
	test -f profiles/a1200-020.conf
	test -f profiles/a1200-020-aros.conf
	test -f profiles/a1200-030.conf
	test -f profiles/a4000.conf
	@# Reject committed proprietary media files, not legitimate FS-UAE option names.
	@! find . -type f \( -iname 'kickstart*.rom' -o -iname 'kickstart*.bin' -o -iname 'workbench*.adf' -o -iname 'workbench*.hdf' \) -print -quit | grep -q .
	@echo 'M2 repository checks: PASS'

container-build:
	docker build -t amiga-runtime:m2 .
