SHELL               = /bin/bash
export LANG         = en_US.UTF-8
export LC_CTYPE     = en_US.UTF-8

.DEFAULT_GOAL := build

update-linux-test-manifest:
	@swift test --generate-linuxmain

play:
	@swift run play

test: clean
	@swift test -Xswiftc -warnings-as-errors

test-linux-docker:
	@Scripts/run-tests-linux-docker.sh

develop-linux-docker:
	@Scripts/develop-linux-docker.sh

generate: clean-xcodeproj-gen
	@echo "Generating Xcode project…"
	@swift package generate-xcodeproj --xcconfig-overrides Resources/release.xcconfig
	@cp Resources/Info.plist Pathos.xcodeproj/Pathos_info.plist
	@echo "Done."

carthage-archive: clean-carthage generate
	@bin/carthage-darwin build --archive

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
