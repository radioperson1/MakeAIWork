#!/usr/bin/env bash

argument_names=("containername" "[entrypoint]" "[script]")
argument_values=("$@")
nr_of_arguments=${#argument_values[@]}

if [ $nr_of_arguments -lt 1 ]; then
    printf "USAGE: %s %s\n" "$0" "${argument_names[*]}"
    exit 1;
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    *)          machine="UNKNOWN:${unameOut}"
esac

name="jaboo/miw"
image="${name}:latest"
containername="${argument_values[0]}"
hostdir_project=${PWD}
hostdir_work="../notebooks"

if [ $machine == "Cygwin" ]; then 
    hostdir_project=$(cygpath -w -p ${hostdir_project})
    hostdir_work=$(cygpath -w -p ${hostdir_work})
fi

containerdir_project="/home/student/project"
containerdir_work="/home/student/notebooks"
cmd="docker run -it --rm --name ${containername}"

# Default entrypoint
if [ $nr_of_arguments -lt 2 ]; then
    portmapping="8888:8888"
    cmd="${cmd} -p${portmapping} -v \"${hostdir_work}:${containerdir_work}\"" 
fi

# Python entrypoint
if [ $nr_of_arguments -gt 1 ]; then 
    # Add entrypoint
    cmd="${cmd} --entrypoint ${argument_values[1]} -v \"${hostdir_project}:${containerdir_project}\""
fi

# Run with script
if [ $nr_of_arguments -gt 2 ]; then 
    script="${containerdir_project}/${argument_values[2]}"
    cmd="${cmd} -e SCRIPT=${script}"  
fi

cmd="${cmd} ${image}"
echo ${cmd} && eval ${cmd}