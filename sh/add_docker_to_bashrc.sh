#!/usr/bin/env bash

dockerPath="/c/Program Files/Docker/Docker/Docker Desktop.exe"

# Make sure the file exists
touch ~/.bashrc 

# Add path to Docker Desktop to .bashrc or show that this has been done already
cat ~/.bashrc | grep 'Docker Desktop' || echo "${dockerPath}" >> ~/.bashrc