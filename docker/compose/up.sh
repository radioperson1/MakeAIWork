#!/usr/bin/env bash

if [ $# -eq 0 ]
  then
    echo "No composefile supplied"
    exit -1
fi

compose_file=$1

docker-compose -f ${compose_file} down

cmd="docker-compose -f ${compose_file} up --remove-orphans"
printf "%s cmd : %s\n" "$0" "${cmd}"