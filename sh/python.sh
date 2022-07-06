#!/usr/bin/env bash

argument_values=("$@")
nr_of_arguments=${#argument_values[@]}

containername="python-ai"
entrypoint="run_script"

# Run with script?
if [ $nr_of_arguments -gt 0 ]; then
  script="${argument_values[0]}"
  printf "Run with script %s\n" ${script}
  entrypoint=${script}
  containername="${containername}-script"
fi

cmd="docker/run/miw_container.sh ${containername} ${entrypoint}"
eval ${cmd}