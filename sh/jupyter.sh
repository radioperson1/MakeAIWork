#!/usr/bin/env bash

cmd="docker/run/miw_container.sh jupyter"

if (! command -v "${cmd}" &> /dev/null) then
    echo Try locally installed jupyter
    cmd="(cd notebooks; jupyter-lab)"
elif (! command -v "${cmd}" &> /dev/null) then 
    echo "${cmd} could not be found" && exit
fi

echo "Open the URL in your browser"
echo "$cmd"
eval ${cmd} | grep -Eo 'http://127.0.0.1:8888/lab\?.*'