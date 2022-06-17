#!/usr/bin/env bash

image="jaboo/miw:0.2"
entrypoint="/opt/conda/bin/python"
containername="python-ai-repl"
portmapping="8888:8888"
hostdir="${PWD}/work"
containerdir="/work"

docker run -it --rm --name ${containername} -v "${hostdir}:${containerdir}" --entrypoint "${entrypoint}" ${image}