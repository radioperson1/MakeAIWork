#!/usr/bin/env bash

export PROJECT="project_1"

entrypoint="/bin/bash"
containername="python-ai-bash"

cmd="sh/start_container.sh ${containername} ${entrypoint}"
eval ${cmd}