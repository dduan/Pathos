#!/bin/bash

set -e
set -o pipefail
set -u

if [ $(uname) != "Darwin" ]; then
    exit 0
fi


current_path=$(PWD)
target_path="./tmp/sourcery"
unzip_path="./tmp/sourcery_unzipped"
download_path="./tmp/sourcery.zip"
expected_version="$(cat .sourcery-version)"

install() {
  rm -rf "$download_path" "$unzip_path"
  mkdir -p ./tmp/
  curl --location --fail --retry 5 \
    "https://github.com/krzysztofzablocki/Sourcery/releases/download/${expected_version}/Sourcery-${expected_version}.zip" \
    --output "$download_path"

  unzip -d "$unzip_path" "$download_path" > /dev/null
  mv "${unzip_path}/bin/Sourcery.app" ./tmp
  mv "${unzip_path}/bin/sourcery" ./tmp
  rm -rf "$download_path" "$unzip_path"

  echo "Downloaded Sourcery $expected_version"
}

if [ ! -x "$target_path" ]; then
  install
elif ! diff <(echo "$expected_version") <("$target_path" --version) > /dev/null; then
  install
fi
