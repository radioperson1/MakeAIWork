#!/usr/bin/env bash

argument_names=("containername" "[entrypoint]" "[script]")
argument_values=("$@")
nr_of_arguments=${#argument_values[@]}

if [ $nr_of_arguments -lt 1 ]; then
    printf "USAGE: %s %s\n" "$0" "${argument_names[*]}"
    exit 1;
fi

name="jaboo/miw"
image="${name}:0.3"
containername="${argument_values[0]}"
containerdir="/project"
hostdir="${PWD}"

cmd="docker run -it --rm --name ${containername}"

# Default entrypoint
if [ $nr_of_arguments -lt 2 ]; then
  containerdir="${containerdir}/notebooks"
  hostdir="${PWD}/notebooks"
  portmapping="8888:8888"
  cmd="${cmd} -p${portmapping}" 
fi

# Python entrypoint
if [ $nr_of_arguments -gt 1 ]; then 
    # Add entrypoint
    cmd="${cmd} --entrypoint "${argument_values[1]}""
fi

# Run with script
if [ $nr_of_arguments -gt 2 ]; then 
    script="${containerdir}/${argument_values[2]}"
    cmd="${cmd} -e SCRIPT=${script}"  
fi

cmd="${cmd} -v \"${hostdir}:${containerdir}\" ${image}"
echo ${cmd} && eval ${cmd}