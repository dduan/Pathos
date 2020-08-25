#!/bin/bash

set -e

version=0.45.6
tmp=tmp
bin=$tmp/swiftformat

if [[ -f $bin ]] && [[ "$($bin --version)" =~ "$version" ]]; then
    exit 0
fi

tar=swiftformat.tar.gz
mkdir -p $tmp
curl -L https://github.com/nicklockwood/SwiftFormat/archive/$version.tar.gz -o $tmp/$tar
pushd $tmp > /dev/null
tar xzf $tar
pushd SwiftFormat-$version /dev/null
swift build -c release
popd > /dev/null
popd > /dev/null
mv tmp/SwiftFormat-$version/.build/release/swiftformat $bin
