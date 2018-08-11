#!/bin/bash

set -e
set -o pipefail
set -u

platform=$(uname)
if [ "$platform" != "Darwin" ]; then
    echo "please update Linux test manifest on Darwin!"
    exit 0
fi

$(dirname $0)/ensure-sourcery.sh
echo "updating Linux test manifest"
# Sourcery doesn't like broken symbolic links -_-
mv Tests/PathosTests/Fixtures tmp
cd Tests && ../tmp/sourcery --sources PathosTests/ --templates LinuxMain.stencil --args testimports="import PathosTests" && cd ..
mv tmp/Fixtures Tests/PathosTests/
