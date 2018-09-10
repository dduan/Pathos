SHELL               = /bin/bash
export LANG         = en_US.UTF-8
export LC_CTYPE     = en_US.UTF-8

.DEFAULT_GOAL := build

generate-linux-test-manifest:
	@swift test --generate-linuxmain
play:
	@swift run play
test:
	@swift test -Xswiftc -warnings-as-errors
test-linux-docker:
	@Scripts/run-tests-linux-docker.sh
develop-linux-docker:
	@Scripts/develop-linux-docker.sh
develop-linux-docker-rebuild:
	@Scripts/develop-linux-docker.sh rebuild
generate:
	@swift package generate-xcodeproj
build: generate-linux-test-manifest
	@echo "building Pathos"
	@swift build -c release -Xswiftc -warnings-as-errors > /dev/null
clean:
	rm -rf .build tmp
