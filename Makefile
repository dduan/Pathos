SHELL               = /bin/bash
export LANG         = en_US.UTF-8
export LC_CTYPE     = en_US.UTF-8

.DEFAULT_GOAL := build

generate-linux-test-manifest:
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
clean:
	rm -rf .build tmp
