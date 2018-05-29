SHELL               = /bin/bash
export LANG         = en_US.UTF-8
export LC_CTYPE     = en_US.UTF-8

play:
	@swift run play
build:
	@swift build
test:
	@swift test
generate:
	@swift package generate-xcodeproj
ensure-sourcery:
	scripts/ensure-sourcery.sh
generate-linux-test-manifest: ensure-sourcery
	cd Tests && ../tmp/sourcery --sources PathosTests/ --templates LinuxMain.stencil --args testimports="import PathosTests"
