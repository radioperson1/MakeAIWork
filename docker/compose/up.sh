#!/usr/bin/env bash

mode=" -d"

# No composefile?
if [ $# -eq 0 ]
  then
    echo "No supplied"
    exit -1
fi

composeFile="$1"

cmd="docker-compose -f ${composeFile} down && docker-compose -f ${composeFile} up${mode} --remove-orphans"
# printf "%s cmd : \n%s\n" "$0" "${cmd}"
eval ${cmd}