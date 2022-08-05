#!/usr/bin/env bash

argumentNames=("mode" "[script]")
argumentValues=("$@")
nrOfArguments=${#argumentValues[@]}

if [ $nrOfArguments -lt 1 ]; then
    printf "USAGE: %s %s\n" "$0" "${argumentNames[*]}"
    exit 1;
fi

# Host

hostdirHome="${PWD}"
hostdirNotebooks="${hostdirHome}/notebooks"
hostdirProjects="${hostdirHome}/projects"
hostdirScripts="${hostdirHome}/scripts"

function makeWindowsProof {
    hostdirNotebooks=$(cygpath -w -p ${hostdirNotebooks})
    hostdirProjects=$(cygpath -w -p ${hostdirProjects})
    hostdirScripts=$(cygpath -w -p ${hostdirScripts})
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

export HOSTPATH_NOTEBOOKS=${hostdirNotebooks}
export HOSTPATH_PROJECT=${hostdirProjects}
export HOSTPATH_SCRIPTS=${hostdirScripts}

# Container

mode="${argumentValues[0]}"

name="jaboo/miw"
version="0.7"
image="${name}:${version}"
containerName="python-ai-${mode}"
containerHome="/home/student"
containerdirNotebooks="${containerHome}/notebooks"
containerdirProjects="${containerHome}/projects"
containerdirScripts="${containerHome}/scripts"
composePath="docker/compose"
graphicsParams="-v \"/tmp/.X11-unix:/tmp/.X11-unix\" -e \"DISPLAY=$DISPLAY\" --net=host"

case "${mode}" in
    bash*)
        entryPoint="bash"
        cmd="${prefix}docker run -it --rm --name ${containerName}"
        cmd="${cmd} -v \"${hostdirProjects}:${containerdirProjects}\""
        cmd="${cmd} -v \"${hostdirNotebooks}:${containerdirNotebooks}\""
        cmd="${cmd} -v \"${hostdirScripts}:${containerdirScripts}\""
        cmd="${cmd} ${graphicsParams} --entrypoint ${entryPoint} ${image}";;
    jupyter*)     
        composefile="${composePath}/python-ai-jupyter.yaml"
        cmd="docker/compose/up.sh ${composefile}";;
    python-repl*)
        entryPoint="ptpython"
        cmd="${prefix}docker run -it --rm --name ${containerName} --entrypoint ${entryPoint} ${image}";;        
    python-script*)
        entryPoint="run_script"
        cmd="${prefix}docker run -it --rm --name ${containerName}"
        cmd="${cmd} -v \"${hostdirProjects}:${containerdirProjects}\""
        cmd="${cmd} -v \"${hostdirNotebooks}:${containerdirNotebooks}\""
        cmd="${cmd} -v \"${hostdirScripts}:${containerdirScripts}\""
        cmd="${cmd} ${graphicsParams} -e SCRIPT=\"${argumentValues[1]}\" --entrypoint ${entryPoint} ${image}";;
    # Default
    *)      
        cmd="${prefix}docker run --rm --name ${containerName} ${image}";;        
esac

# Set environment variables for Docker
export IMAGE=${image}
export CONTAINER_NAME=${containerName}

# printf "%s cmd : \n%s\n" "$0" "${cmd}"
eval ${cmd}
