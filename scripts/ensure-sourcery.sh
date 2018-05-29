#!/bin/bash

set -e
set -o pipefail
set -u

current_path=$(PWD)
target_path="./tmp/sourcery"
source_path="./tmp/src/sourcery"
download_path="./tmp/sourcery.tar.gz"
expected_version="$(cat .sourcery-version)"

install() {
  rm -rf "$source_path" "$download_path"
  mkdir -p ./tmp/src
  curl --location --fail --retry 5 \
    https://github.com/krzysztofzablocki/Sourcery/archive/"$expected_version".tar.gz \
    --output "$download_path"

  tar -zxvf "$download_path" -C ./tmp > /dev/null
  mv ./tmp/Sourcery-"$expected_version" "$source_path"
  rm -f "$download_path"

  cd "$source_path" && swift build -c release && cd "$current_path"
  mv "${source_path}/.build/release/sourcery" "$target_path"
  echo "Built Sourcery $expected_version"
}

if [ ! -x "$target_path" ]; then
  install
elif ! diff <(echo "$expected_version") <("$target_path" --version) > /dev/null; then
  install
fi
