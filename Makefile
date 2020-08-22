SHELL               = /bin/bash
export LANG         = en_US.UTF-8
export LC_CTYPE     = en_US.UTF-8

.DEFAULT_GOAL := build

update-linux-test-manifest:
	@rm Tests/PathosTests/XCTestManifests.swift
	@touch Tests/PathosTests/XCTestManifests.swift
	@swift test --generate-linuxmain

test: clean
	@swift test -Xswiftc -warnings-as-errors

test-docker:
	@Scripts/docker.sh Pathos test 5.2.5 bionic

test-codegen: update-linux-test-manifest
	@git diff --exit-code

build: update-linux-test-manifest
	@swift build -c release -Xswiftc -warnings-as-errors > /dev/null


clean:
	@echo "Deleting build artifacts…"
	@rm -rf .build tmp build
	@echo "Done."

test-SwiftPM:
	@swift test -Xswiftc -warnings-as-errors
