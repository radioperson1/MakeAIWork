#!/usr/bin/env bash

entrypoint="/opt/conda/bin/python"
containername="python-ai-repl"

cmd="sh/start_container.sh ${containername} ${entrypoint}"
eval ${cmd}