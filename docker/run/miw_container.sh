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
version="0.7"
image="${name}:${version}"
containerName="python-ai-${mode}"
containerHome="/home/student"
containerdir_notebooks="${containerHome}/notebooks"
containerdir_projects="${containerHome}/projects"
containerdir_scripts="${containerHome}/scripts"
composepath="docker/compose"
graphicsParams="-v \"/tmp/.X11-unix:/tmp/.X11-unix\" -e \"DISPLAY=$DISPLAY\" --net=host"

case "${mode}" in
    bash*)
        entryPoint="bash"
        cmd="${prefix}docker run -it --rm --name ${containerName}"
        cmd="${cmd} -v \"${hostdir_projects}:${containerdir_projects}\""
        cmd="${cmd} -v \"${hostdir_notebooks}:${containerdir_notebooks}\""
        cmd="${cmd} -v \"${hostdir_scripts}:${containerdir_scripts}\""
        cmd="${cmd} ${graphicsParams} --entrypoint ${entryPoint} ${image}";;
    jupyter*)     
        composefile="${composepath}/python-ai-notebook.yaml"
        cmd="docker/compose/up.sh ${composefile}";;
    python-repl*)
        entryPoint="ptpython"
        cmd="${prefix}docker run -it --rm --name ${containerName} --entrypoint ${entryPoint} ${image}";;        
    python-script*)
        entryPoint="run_script"
        cmd="${prefix}docker run -it --rm --name ${containerName}"
        cmd="${cmd} -v \"${hostdir_projects}:${containerdir_projects}\""
        cmd="${cmd} -v \"${hostdir_notebooks}:${containerdir_notebooks}\""
        cmd="${cmd} -v \"${hostdir_scripts}:${containerdir_scripts}\""
        cmd="${cmd} ${graphicsParams} -e SCRIPT=\"${argument_values[1]}\" --entrypoint ${entryPoint} ${image}";;
    # Default
    *)      
        cmd="${prefix}docker run --rm --name ${containerName} ${image}";;        
esac

# Set environment variables for Docker
export IMAGE=${image}
export CONTAINER_NAME=${containerName}

printf "%s cmd : \n%s\n" "$0" "${cmd}"
eval ${cmd}
