#!/usr/bin/env bash

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1;
fi

containername="python-ai-script"
entrypoint="/run_script.sh"
script="$1"

cmd="./start_container.sh ${entrypoint} ${containername} ${script}"
echo $cmd
eval $cmd