#!/usr/bin/env bash

export PROJECT="project_1"

containername="python-ai-bash"
entrypoint="/bin/bash"

cmd="run/container.sh ${containername} ${entrypoint}"
echo ${cmd}
eval ${cmd}