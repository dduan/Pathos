#!/bin/bash

set -e
set -o pipefail
set -u

tests_changed=$(git status -s Tests/PathosTests)
if [[ -n "$tests_changed" ]]; then
	echo "updating Linux test manifest"
	cd Tests && ../tmp/sourcery --sources PathosTests/ --templates LinuxMain.stencil --args testimports="import PathosTests" > /dev/null
fi
