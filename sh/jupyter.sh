#!/usr/bin/env bash

cmd="docker/run/miw_container.sh jupyter"
runnable="docker"

# No docker?
if (! command -v ${runnable} &> /dev/null) then
    echo "Try locally installed jupyter"
    runnable="jupyter-lab"

    if (! command -v ${runnable} &> /dev/null) then 
        echo "${runnable} could not be found"
        exit -1
    else
        cmd="(cd notebooks; ${runnable})"  
    fi

fi

printf "%s cmd : %s\n" "$0" "${cmd}"

eval ${cmd} > log.txt
sleep 5s;
url=$(cat log.txt | grep -Eo 'http://127.0.0.1:8888/lab\?.*' | tail -n1)
rm log.txt
printf "Open %s in your browser\n" "${url}"
python -m webbrowser ${url}