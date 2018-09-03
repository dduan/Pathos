#!/usr/bin/env bash

IMAGE=pathostesting
docker image rm -f "$IMAGE" 2>/dev/null
docker build -t "$IMAGE" -f Scripts/Dockerfile-testing-linux . && docker run --rm "$IMAGE"
