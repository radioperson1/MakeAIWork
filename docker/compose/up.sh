#!/usr/bin/env bash

postfix=""

# No composefile?
if [ $# -eq 0 ]
  then
    echo "No composefile supplied"
    exit -1
# Run in background? 
elif [ $# -gt 1 ]
  then 
    if [ $2 -eq 0 ]
      then
        postfix=" &"
    fi
fi

compose_file=$1

docker-compose -f ${compose_file} down

cmd="docker-compose -f ${compose_file} up --remove-orphans${postfix}"
printf "%s cmd : %s\n" "$0" "${cmd}"
eval ${cmd}