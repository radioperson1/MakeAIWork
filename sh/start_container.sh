#!/usr/bin/env bash

export PROJECT="project_1"

if [ $# -lt 2 ]
  then echo "Too less arguments supplied" && exit 1;    
fi

entrypoint="$1"
containername="$2"
echo $script

image="jaboo/miw:0.2"
portmapping="8888:8888"
hostdir="${PWD}/../${PROJECT}"
containerdir="/project"

if [ $# -gt 2 ]
  # Run with script
  script="${containerdir}/python/$3"
  then docker run -it --rm -e SCRIPT=${script} --name ${containername} -v "${hostdir}:${containerdir}" --entrypoint "${entrypoint}" ${image}
else
  docker run -it --rm --name ${containername} -v "${hostdir}:${containerdir}" --entrypoint "${entrypoint}" ${image}
fi