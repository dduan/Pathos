#!/usr/bin/env bash

IMAGE=pathosdev

if [ "$1" == 'rebuild' ]; then
docker image rm -f "$IMAGE" 2>/dev/null
docker build -t "$IMAGE" -f Scripts/Dockerfile-develop-linux .
fi

docker run -it -v "$PWD":/Pathos --rm "$IMAGE"
