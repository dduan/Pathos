#!/bin/bash

if ! command -v docker > /dev/null; then
    echo "Install docker https://docker.com" >&2
    exit 1
fi
project=$1
action=$2
swift=$3
ubuntu=$4
dockerfile=$(mktemp)
echo "FROM swift:$swift-$ubuntu"    >  $dockerfile
echo "ADD . $project"               >> $dockerfile
echo "WORKDIR $project"             >> $dockerfile
echo "RUN make $action"             >> $dockerfile
image=$(echo $project | tr '[:upper:]' '[:lower:]')
docker image rm -f $image &> /dev/null
docker build -t $image -f $dockerfile .
docker run --rm $image
