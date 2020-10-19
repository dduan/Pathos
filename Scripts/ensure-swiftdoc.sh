#!/bin/bash

set -e

version=1.0.0-beta.5
tmp=tmp
bin=$tmp/swift-doc

if [[ -f $bin ]] && [[ "$($bin --version)" =~ "$version" ]]; then
    exit 0
fi

tar=swiftdoc.tar.gz
mkdir -p $tmp
curl -L https://github.com/SwiftDocOrg/swift-doc/archive/$version.tar.gz -o $tmp/$tar
pushd $tmp > /dev/null
tar xzf $tar
pushd swift-doc-$version /dev/null
swift build -c release
popd > /dev/null
popd > /dev/null
mv tmp/swift-doc-$version/.build/release/swift-doc $bin
