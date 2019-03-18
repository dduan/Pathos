#!/usr/bin/env bash

expected_version=$(cat Documentation/.jazzy-version)
raw_version=$(jazzy --version)
version=${raw_version#"jazzy version: "}

if [ ${expected_version} != ${version} ]; then
    sudo gem install jazzy -v "${expected_version}"
else
    echo "Found expecetd Jazzy ${expected_version}!"
fi
