#!/bin/bash

set -e
set -o pipefail
set -u

platform=$(uname)
tests_changed=$(git status -s Tests/PathosTests)
if [[ -n "$tests_changed" ]]; then
    if [ "$platform" != "Darwin" ]; then
        echo "please update Linux test manifest on Darwin!"
        exit 0
    fi
	echo "updating Linux test manifest"
	cd Tests && ../tmp/sourcery --sources PathosTests/ --templates LinuxMain.stencil --args testimports="import PathosTests" > /dev/null
fi
