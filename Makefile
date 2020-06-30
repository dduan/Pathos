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
	@Scripts/ubuntu.sh Pathos test 5.2 bionic

test-codegen: update-linux-test-manifest docs
	@git diff --exit-code

xcode: clean-xcodeproj-gen
	@echo "Generating Xcode project…"
	@swift package generate-xcodeproj --xcconfig-overrides Resources/release.xcconfig
	@cp Resources/Info.plist Pathos.xcodeproj/Pathos_info.plist
	@echo "Done."

build: update-linux-test-manifest
	@swift build -c release -Xswiftc -warnings-as-errors > /dev/null

clean-xcodeproj-gen:
	@echo "Deleting generated Xcode project…"
	@rm -rf Pathos.xcodeproj

clean:
	@echo "Deleting build artifacts…"
	@rm -rf .build tmp build
	@echo "Done."

ensure-jazzy:
	Scripts/ensure-jazzy.sh

docs: xcode ensure-jazzy
	@Scripts/generate-docs.sh

test-SwiftPM:
	swift test -Xswiftc -warnings-as-errors

ensure-CocoaPods:
	sudo gem install cocoapods -v 1.6.0

test-CocoaPods: ensure-CocoaPods
	pod lib lint --verbose
