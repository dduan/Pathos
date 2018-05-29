SHELL               = /bin/bash
export LANG         = en_US.UTF-8
export LC_CTYPE     = en_US.UTF-8

.DEFAULT_GOAL := build

ensure-sourcery:
	@Scripts/ensure-sourcery.sh
generate-linux-test-manifest: ensure-sourcery
	@Scripts/generate-linux-test-manifest.sh
play:
	@swift run play
test:
	@swift test
generate:
	@swift package generate-xcodeproj
build: generate-linux-test-manifest
	@echo "building Pathos"
	@swift build -c release > /dev/null
