#!/usr/bin/env bash

export PROJECT="project_1"

./start_docker_compose.sh ../yaml/jupyter.yaml | grep -Eo 'http://127.0.0.1:8888/lab\?.*'