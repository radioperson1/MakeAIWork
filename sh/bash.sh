#!/usr/bin/env bash

containername="python-ai-bash"
entrypoint="/bin/bash"

cmd="docker/run/miw_container.sh ${containername} ${entrypoint}"
eval ${cmd}