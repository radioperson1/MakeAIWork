#!/usr/bin/env bash

containername="python-ai-jupyter"

cmd="docker/run/miw_container.sh ${containername}"

echo "Open the URL in your browser"
eval ${cmd} | grep -Eo 'http://127.0.0.1:8888/lab\?.*'