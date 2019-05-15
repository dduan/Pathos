#!/usr/bin/env bash

command -v docker &> /dev/null || { echo >&2 "Install docker https://www.docker.com"; exit 1; }
IMAGE=swift@sha256:6b85beec4ef69d2d520e84c053ae7c745193ee3bbf328f4692dd238dd63f924e
NAME=pathosdev
docker run -it -v "$PWD":/Pathos --name "$NAME" --rm "$IMAGE"
