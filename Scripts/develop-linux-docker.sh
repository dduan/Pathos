#!/usr/bin/env bash

command -v docker > /dev/null 2&>1 || { echo >&2 "Install docker https://www.docker.com"; exit 1; }

IMAGE=pathosdev

if [ "$1" == 'rebuild' ]; then
docker image rm -f "$IMAGE" 2&>1 > /dev/null
docker build -t "$IMAGE" -f Scripts/Dockerfile-develop-linux .
fi

docker run -it -v "$PWD":/Pathos --rm "$IMAGE"
