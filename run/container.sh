#!/usr/bin/env bash

argument_values=("$@")
nr_of_arguments=${#argument_values[@]}

name="jaboo/miw"
version=0.2
image="${name}:${version}"
portmapping="8888:8888"
hostdir="${PWD}/project"
# hostdir=${PWD}
nr=$(echo ${version} | sed 's/\.//')
student="stud${nr}"
containerdir="/home/${student}/project"

# Default entrypoint
if [ $nr_of_arguments -gt 0 ]; then
  containername="${argument_values[0]}"
fi

cmd="docker run -it --rm --env STUDENT=${student} --name ${containername} -p8888:8888 -v \"${hostdir}:${containerdir}\""

# Python entrypoint
if [ $nr_of_arguments -gt 1 ]; then 
    # Add entrypoint
    cmd="${cmd} --entrypoint "${argument_values[1]}""
fi

# Run with script
if [ $nr_of_arguments -gt 2 ]; then 
    # Run Jupyter
    script="${containerdir}/$3"
    cmd="${cmd} -e SCRIPT=${script}"  
fi

cmd="${cmd} ${image}"
echo ${cmd}
eval ${cmd}