.PHONY: check container-build

check:
	sh -n bin/amiga-runtime
	test -f profiles/a500.conf
	test -f profiles/a500plus.conf
	test -f profiles/a1200-020.conf
	test -f profiles/a1200-030.conf
	test -f profiles/a4000.conf
	! grep -RIE --exclude='Makefile' --exclude='README.md' --exclude='ROADMAP.md' --exclude='M0_ARCHITECTURE.md' '(kickstart.*\.(rom|bin)|workbench.*\.(adf|hdf))' .
	@echo 'M0 repository checks: PASS'

container-build:
	docker build -t amiga-runtime:m0 .
