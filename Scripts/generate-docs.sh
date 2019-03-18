#!/usr/bin/env bash

output=$(mktemp -d)
cp -r .git "${output}"
pushd "${output}"
git branch -D gh-pages
git fetch
git checkout -f gh-pages
git clean -fxd
popd
jazzy --config Documentation/jazzy.json --output "${output}"
head=$(git log -1 --pretty=oneline)
pushd "${output}"
git add .
git commit -m "${head}"

read -p "Deploy documentation site (y/N)? " deploy
if [ "${deploy}" == "y" ] || [ "${deploy}" == "Y" ]; then
    git push origin gh-pages
    if [ $? -eq 0 ]; then
        popd
        read -p "Clean up the generated site (Y/n)?" cleanup
        if [ "${cleanup}" == "n" ] || [ "${cleanup}" == "N" ]; then
            echo "Okay. The generated site is at:"
            echo "${output}"
        else
            rm -rf "${output}"
        fi
    else
        echo "Push failed. The generate site is at:"
        echo "${output}"
    fi
else
    echo "Okay. The generated site is at:"
    echo "${output}"
fi
