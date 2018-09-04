#!/usr/bin/env bash

command -v docker &> /dev/null  || { echo >&2 "Install docker https://www.docker.com"; exit 1; }

IMAGE=pathostesting
docker image rm -f "$IMAGE" &> /dev/null
docker build -t "$IMAGE" -f Scripts/Dockerfile-testing-linux . && docker run --rm "$IMAGE"
