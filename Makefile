.PHONY: check container-build

check:
	sh -n bin/amiga-runtime
	sh -n bin/prepare-aros
	sh -n bin/run-aros
	sh -n bin/qualify-aros-boot
	python3 -m py_compile lib/write-result.py lib/generate-fs-uae-config.py
	test -f profiles/a500.conf
	test -f profiles/a500plus.conf
	test -f profiles/a1200-020.conf
	test -f profiles/a1200-030.conf
	test -f profiles/a4000.conf
	@# Reject committed proprietary media files, not legitimate FS-UAE option names.
	@! find . -type f \( -iname 'kickstart*.rom' -o -iname 'kickstart*.bin' -o -iname 'workbench*.adf' -o -iname 'workbench*.hdf' \) -print -quit | grep -q .
	@echo 'M1 repository checks: PASS'

container-build:
	docker build -t amiga-runtime:m1 .
