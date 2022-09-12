#!/usr/bin/env bash

cmd="python3 -m jupyterlab"

printf "%s cmd : \n\t%s\n\n" "$0" "${cmd}"
eval ${cmd}
