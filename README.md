# MakeAIWork

## Projects

This repository contains sources to be used by python students. Directory <i>project</i> contains the (re)sources:
<ul>
<li>p1, p2 and p3</i> containing
<i>cursus_materiaal</i> with a project description
<li>scripts</li> with some example Python scripts 
</ul>

Directory <i>notebooks</i> contains Jupyter notebooks that can be used in Jupyter Lab.

## Python AI Workspace
Students use a containerised Python environment running a [Docker](https://www.docker.com/) image. 

### Files available to the container
The project files are accessible in the containerised runtime environment by means of a bind mount between the current (host)directory project and/or notebooks on your laptop and <i>/home/student/project</i> and/or <i>/home/student/nontebooks</i> at the container instance.
<br>

***CAUTION***
<br>
You can remove both container and image without data loss but be aware that files removed from the container directory /project will also be removed from you host directory project.
<br>

### Start a Python container
Docker scripts can be found in <i>docker</i>. Each of the scripts below will call <i>docker/run/miw_container.sh</i> to facilitate the following runtimes:
<b>REPL</b> (Read Evaluate Print Loop) modus to experimentally learn Python commands. Exit by pressing [Control+D].

```bash 
sh/python.sh
```
Start python with a <b>script</b> from directory <i>project</i>

```bash 
sh/python.sh scripts/lists/sum.py
```
Start <b>Jupyter Server</b> to learn from the <i>notebooks</i> available at <i>project/notebooks</i>

```bash 
sh/jupyter.sh
```
Start container with an interactive <b>bash</b> (expert mode) to perform system operations

```sh
sh/bash.sh
```

### Docker artifacts
Each of the above scripts will call run/miw_container.sh which will spin up a container based on the latest version of 'jaboo/miw' which is either stored locally or will be fetched from available at [Dockerhub](https://hub.docker.com/repository/docker/jaboo/miw). 

Inspect locally stored images with
```sh
docker images
```

The containers will be removed automatically after being terminated. For overview of both running and terminated containers enter  
```sh
docker container
```

</li>

</ul>

### Removing Docker artifacts
Docker images and containers can be removed (if not done automatically) by running
```sh
run/clean_docker_artifacts.sh
```

***NOTE
Removing images and/containers will not cause data loss. After removing the image, Docker will pull a new instance when you start a container. 

---
## Setup Workspace

### Windows

#### Windows Subsystem for Linux 
To be able to use Docker, Windows Subsystem for Linux (WSL) needs to be activated. This can be done by running the following commands in <b>Powershell</b>. 

Enable WSL2
```pwsh
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

 Enable the Virtual Machine Platform feature
```pwsh
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Make WSL 2 Default
```pwsh
wsl –set-default-version 2
```

Download and install [Docker Desktop on Windows](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe)<br>
Check if you are able to use Docker by running the following in <b>Git Bash</b>
```sh
docker run hello-world
```

Configure Docker Desktop to start when you login.

Install [Cygwin](https://www.cygwin.com/) and select <i>git</i> te be installed as additional package.

Install [Visual Studio Code](https://code.visualstudio.com/).

### Clone the source code

Create a [Github](https://github.com/) account. 

Start a shell and generate a secret key pair with your student email adress
```sh
ssh-keygen -t Ed25519 -C {your@student.email.com}
```
Copy your <b>public</b> key to your github profile.

Create a fork of this repository and clone your <b>fork</b> from the shell
```sh
git clone git@{your_github_username}/MakeAIWork
```

### References
[How to Install the SSH-Agent Service in Windows](https://interworks.com/blog/2021/09/15/setting-up-ssh-agent-in-windows-for-passwordless-git-authentication/)<br>
[How to Use Linux Terminal in Windows 10](https://allthings.how/how-to-use-linux-terminal-in-windows-10/)<br>
[Jupyter](https://jupyter.org/)
