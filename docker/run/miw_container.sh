#!/usr/bin/env bash

argument_names=("mode" "[script]")
argument_values=("$@")
nr_of_arguments=${#argument_values[@]}

if [ $nr_of_arguments -lt 1 ]; then
    printf "USAGE: %s %s\n" "$0" "${argument_names[*]}"
    exit 1;
fi

# Host

hostdir_home="${PWD}"
hostdir_notebooks="${hostdir_home}/notebooks"
hostdir_projects="${hostdir_home}/projects"
hostdir_scripts="${hostdir_home}/scripts"

function makeWindowsProof {
    echo "makeWindowsProof"
    hostdir_notebooks=$(cygpath -w -p ${hostdir_notebooks})
    hostdir_projects=$(cygpath -w -p ${hostdir_projects})
    hostdir_scripts=$(cygpath -w -p ${hostdir_scripts})
    prefix="winpty "
}

# Windows environment?
prefix=""
unameOut="$(uname -s)"
os="${unameOut:0:7}"
case "${os}" in
    Linux*)     machine="Linux";;
    Darwin*)    machine="Mac";;
    CYGWIN*)    machine="Cygwin" && makeWindowsProof;;
    MINGW*)     machine="Git Bash" && makeWindowsProof;;
    *)          machine="UNKNOWN:${os}"
esac

export HOSTPATH_NOTEBOOKS=${hostdir_notebooks}
export HOSTPATH_PROJECT=${hostdir_projects}
export HOSTPATH_SCRIPTS=${hostdir_scripts}

# Container

mode="${argument_values[0]}"

name="jaboo/miw"
image="${name}:latest"
containername="python-ai-${mode}"
container_home="/home/student"
containerdir_notebooks="${container_home}/notebooks"
containerdir_projects="${container_home}/projects"
containerdir_scripts="${container_home}/scripts"
composepath="docker/compose"

case "${mode}" in
    bash*)
        entrypoint="bash"
        cmd="${prefix}docker run -it --rm --name ${containername} --entrypoint ${entrypoint} \
            -v \"${hostdir_projects}:${containerdir_projects}\" \
            -v \"${hostdir_notebooks}:${containerdir_notebooks}\" \
            -v \"${hostdir_scripts}:${containerdir_scripts}\" \
            ${image}";;        
    jupyter*)     
        composefile="${composepath}/python-ai-notebook.yaml"
        cmd="docker-compose -f ${composefile} down; docker-compose -f ${composefile} up";;
    python-repl*)
        entrypoint="bpython"
        cmd="${prefix}docker run -it --rm --name ${containername} --entrypoint ${entrypoint} ${image}";;        
    python-script*)
        composefile="${composepath}/python-ai-script.yaml"
        export SCRIPT="${argument_values[1]}"
        cmd="docker-compose -f ${composefile} down; docker-compose -f ${composefile} up";;
    *)      
        cmd="${prefix}docker run --rm --name ${containername} ${image}";;        
esac

export IMAGE=${image}

printf "%s cmd : %s\n" "$0" "${cmd}"
eval ${cmd}