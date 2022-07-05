#!/usr/bin/env bash

argument_names=("containername" "[entrypoint]" "[script]")
argument_values=("$@")
nr_of_arguments=${#argument_values[@]}

if [ $nr_of_arguments -lt 1 ]; then
    printf "USAGE: %s %s\n" "$0" "${argument_names[*]}"
    exit 1;
fi

# Host

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    *)          machine="UNKNOWN:${unameOut}"
esac

hostdir_home="${PWD}"
hostdir_notebooks="${hostdir_home}/notebooks"
hostdir_projects="${hostdir_home}/projects"
hostdir_scripts="${hostdir_home}/scripts"

if [ $machine == "Cygwin" ]; then 
    hostdir_projects=$(cygpath -w -p ${hostdir_projects})
    hostdir_notebooks=$(cygpath -w -p ${hostdir_notebooks})
fi

# Container

name="jaboo/miw"
image="${name}:latest"
containername="${argument_values[0]}"
container_home="/home/student"
containerdir_notebooks="${container_home}/notebooks"
containerdir_projects="${container_home}/projects"
containerdir_scripts="${container_home}/scripts"
cmd="docker run -it --rm --name ${containername}"

# Default entrypoint
if [ $nr_of_arguments -lt 2 ]; then
    portmapping="8888:8888"
    # Add pormapping and map directory notebooks
    cmd="${cmd} -p${portmapping} -v \"${hostdir_notebooks}:${containerdir_notebooks}\"" 
else
    # Add entrypoint and map directory project
    cmd="${cmd} --entrypoint ${argument_values[1]} -v \"${hostdir_projects}:${containerdir_projects}\" -v \"${hostdir_scripts}:${containerdir_scripts}\""
fi

# Run with script
if [ $nr_of_arguments -gt 2 ]; then 
    script="${container_home}/${argument_values[2]}"
    cmd="${cmd} -e SCRIPT=${script}"  
fi

cmd="${cmd} ${image}"
echo ${cmd} && eval ${cmd}