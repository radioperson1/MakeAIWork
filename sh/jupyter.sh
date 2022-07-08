#!/usr/bin/env bash

cmd="docker/run/miw_container.sh jupyter"

echo "Open the URL in your browser"
echo "$cmd"
eval ${cmd} | grep -Eo 'http://127.0.0.1:8888/lab\?.*'