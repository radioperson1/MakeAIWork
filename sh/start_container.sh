#!/usr/bin/env bash

export PROJECT="project_1"

if [ $# -lt 1 ]
  then echo "Too less arguments supplied\nUSAGE : $0 containername [entrypoint] [script]" && exit 1;    
fi

containername="$1"
name="jaboo/miw"
version=0.2
image="${name}:${version}"
portmapping="8888:8888"
hostdir="${PWD}/${PROJECT}"
nr=$(echo ${version} | sed 's/\.//')
student="stud${nr}"
containerdir="/home/${student}/project"
# containerdir="/project"

cmd="docker run -it --rm --env STUDENT=${student} --name ${containername} -p8888:8888 -v '${hostdir}:${containerdir}'"

# Run with entrypoint?
if [ $# -gt 1 ]
  then 
    entrypoint="$2"
    # printf "entrypoint : %s\n" $entrypoint
    cmd="${cmd} --entrypoint ${entrypoint}"
fi

# Run with script?
if [ $# -gt 2 ]
  then 
    script="${containerdir}/python/$3"
    cmd="${cmd} -e SCRIPT=${script}"  
fi

cmd="${cmd} ${image}"
eval ${cmd}