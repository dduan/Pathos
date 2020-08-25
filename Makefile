SHELL               = /bin/bash
export LANG         = en_US.UTF-8
export LC_CTYPE     = en_US.UTF-8

.DEFAULT_GOAL := build

.PHONY: codegen
codegen: update-cmake-lists update-test-manifest format

update-test-manifest:
	@echo "Updating SwiftPM test manifests"
ifeq ($(shell uname),Darwin)
	@rm Tests/PathosTests/XCTestManifests.swift
	@touch Tests/PathosTests/XCTestManifests.swift
	@swift test --generate-linuxmain
else
	@echo "Skiping test manifest update: only works on macOS."
endif

update-cmake-lists:
	@echo "Updating cmake config files"
	@python3 Scripts/update-cmake.py Scripts/cmake_root

test: clean
	@swift test -Xswiftc -warnings-as-errors

test-docker:
	@Scripts/docker.sh Pathos 'swift test -Xswiftc -warnings-as-errors' 5.2.5 bionic

test-codegen: codegen
	@git diff --exit-code

build: update-linux-test-manifest
	@swift build -c release -Xswiftc -warnings-as-errors > /dev/null

clean:
	@echo "Deleting build artifacts…"
	@rm -rf .build tmp build
	@echo "Done."

test-SwiftPM:
	@swift test -Xswiftc -warnings-as-errors

format: ensure-swiftformat
ifeq ($(shell uname),Darwin)
	@./tmp/swiftformat --swiftversion 5.3 .
else
	@echo "Skiping formatting: only works on macOS."
endif

ensure-swiftformat:
	@Scripts/ensure-swiftformat.sh
