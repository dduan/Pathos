#!/usr/bin/env bash

command -v docker &> /dev/null || { echo >&2 "Install docker https://www.docker.com"; exit 1; }

IMAGE=swift@sha256:642beec6d119c3f2e22740bf91f6ca383727237794db8980d5d00ea71d117394
NAME=pathosdev
docker run -it -v "$PWD":/Pathos --name "$NAME" --rm "$IMAGE"
