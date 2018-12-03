SHELL               = /bin/bash
export LANG         = en_US.UTF-8
export LC_CTYPE     = en_US.UTF-8

.DEFAULT_GOAL := build

test-all: test test-carthage

update-linux-test-manifest:
	@rm Tests/PathosTests/XCTestManifests.swift
	@swift test --generate-linuxmain

test: clean
	@swift test -Xswiftc -warnings-as-errors

test-linux-docker:
	@Scripts/run-tests-linux-docker.sh

develop-linux-docker:
	@Scripts/develop-linux-docker.sh

xcode: clean-xcodeproj-gen
	@echo "Generating Xcode project…"
	@swift package generate-xcodeproj --xcconfig-overrides Resources/release.xcconfig
	@cp Resources/Info.plist Pathos.xcodeproj/Pathos_info.plist
	@echo "Done."

test-carthage: clean-carthage generate ensure-carthage
	set -o pipefail && \
		carthage build \
		--no-skip-current \
		--configuration Release \
		--verbose
	ls Carthage/build/Mac/Pathos.framework

test-cocoapods:
	pod lib lint

carthage-archive: clean-carthage generate ensure-carthage
	@carthage build --archive

ensure-carthage:
	@brew update
	@brew outdated carthage || brew upgrade carthage

build: update-linux-test-manifest
	@swift build -c release -Xswiftc -warnings-as-errors > /dev/null

clean-xcodeproj-gen:
	@echo "Deleting generated Xcode project…"
	@rm -rf Pathos.xcodeproj

clean-carthage: clean-xcodeproj-gen
	@echo "Deleting Carthage artifacts…"
	@rm -rf Carthage
	@rm -rf Pathos.framework.zip

clean: clean-carthage
	@echo "Deleting build artifacts…"
	@rm -rf .build tmp build
	@echo "Done."
