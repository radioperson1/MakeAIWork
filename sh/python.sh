#!/usr/bin/env bash

argument_values=("$@")
nr_of_arguments=${#argument_values[@]}

containername="python-ai"
name="jaboo/miw"
image="${name}:latest"
entrypoint="run_script"

# Run with script?
if [ $nr_of_arguments -gt 0 ]; then
  script="${argument_values[0]}"
  printf "Run with script %s\n" ${script}
  cmd="(cd docker/run; export SCRIPT=${script}; export IMAGE=${image}; docker-compose down; docker-compose up python-script)"
else
  cmd="(docker run -it --rm --name python-repl --entrypoint=${entrypoint} ${image})"
fi

echo ${cmd}
eval ${cmd}