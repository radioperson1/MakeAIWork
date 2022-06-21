#!/usr/bin/env bash

if [ $# -eq 0 ] 
then
  echo "Too less arguments supplied\nUSAGE : runscript script"
  exit 1;
fi

script="$1"
containername="python-ai-script"
entrypoint="run_script"

cmd="sh/start_container.sh ${containername} ${entrypoint} ${script}"
eval ${cmd}