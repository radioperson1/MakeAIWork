#!/usr/bin/env bash

argument_values=("$@")
nr_of_arguments=${#argument_values[@]}

# Run with script?
if [ $nr_of_arguments -gt 0 ]; then
  script="${argument_values[0]}"
  printf "Run with script %s\n" ${script}
  cmd="docker/run/miw_container.sh python-script ${script}"  
else
  cmd="docker/run/miw_container.sh python-repl"  
fi

echo ${cmd}
eval ${cmd}