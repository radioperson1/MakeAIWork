#!/usr/bin/env bash

mode=" -d"

# No composefile?
if [ $# -eq 0 ]
  then
    echo "No supplied"
    exit -1
fi

compose_file=$1

cmd="docker-compose -f ${compose_file} down && docker-compose -f ${compose_file} up${mode} --remove-orphans"
printf "%s cmd : \n%s\n" "$0" "${cmd}"
eval ${cmd}