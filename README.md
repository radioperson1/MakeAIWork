# MakeAIWork

## Projects

This repository contains sources to be used by python students. Directory <i>projects</i> contains the (re)sources:
<ul>
<li>p1, p2 and p3</i> containing
<i>cursus_materiaal</i> with a project description
</ul>

Directory <i>notebooks</i> contains Jupyter notebooks that can be used in Jupyter Lab. Directory <i>scripts</i> contains some example Python scripts. 

---

## Python AI Workspace Installation
Watch [instruction videos at YouTube](https://studio.youtube.com/channel/UCGBzbt5f8_AKVY9TYSEDZWw) 

### Clone this Git repository
To be able to use this repository and handover your code, you need to have remote access to Github.

<ol>

<li>

**Create an account at [Github](https://github.com)**

</li>

<li>

**Install Git**

Make sure you select "Checkout as-is, commit Unix-style line endings" during the installation process. 

<ul>

<li>

[Git for Windows](https://gitforwindows.org/)

</li>

<li>

[Git for Mac](https://git-scm.com/download/mac)

</li>

</ul>

<li>

**Install [Homebrew](https://brew.sh/) (MacOS only)**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

</li>

<li>

**Install [GitHub client](https://cli.github.com/) (MacOS and Linux)**

```bash
brew install gh
```

</li>

<li>

**Create a ssh key-pair token**

Start a (git) bash shell *and generate a secret key pair with your student email adress

```sh
ssh-keygen -t Ed25519 -C {your@student.email.com}
```

</li>

<li>

**Transfer your <b>public</b> key to Github**

If you installed the GitHub client, you can authenticate with the following command in the terminal and select ssh for authentication

```sh
gh auth login
```

otherwise enter the following in (git) bash shell to view the contents of your public key

```sh
cat ~/.ssh/id_ed25519.pub
```
and paste this in the text area when adding a [new ssh key in GitHub](https://github.com/settings/ssh/new)

</li>

<li>

**Create a fork of this repository** 

Create a fork of MitwRdam/MakeAIWork in [GitHub](https://github.com/MitwRdam/MakeAIWork) or 
use the GitHub Client by entering the following commands in your terminal

```bash
gh repo fork https://github.com/MitwRdam/MakeAIWork
```
</li>

<li>

**Clone your <b>fork</b>**
If you installed the GitHub client, you can authenticate with the following command in the terminal

```sh
gh repo clone git@github.com:{your_github_username}/MakeAIWork.git
```

otherwise enter the following command in your (git)bash shell after replacing {your_github_username} with your GitHub username.
```sh
git clone git@github.com:{your_github_username}/MakeAIWork.git
```

</li>

<li>

**Add execution permissions to the shell scripts**
```bash
chmod +x sh/*.sh
```

</li>

<li>

**Configure git**

In order to commit and push your changes, you need identitify yourself. 

Open a (git)bash, enter directory MakeAIWork and run:
```bash
sh/git_config.sh {your_github_username} {your@student.email.com}
```
This script will also set the [pull policy](https://www.git-scm.com/docs/git-pull) to rebase.

</li>

<li>

**Add upstream to original remote repository**

To be able To be able to fetch and merge changes from this repository using (bash) commands, you need to have a (second) upstream.  
If you used the GitHub client to create the fork you can <strong>skip</strong> this step, otherwise enter the following commands

```bash
git remote add mitwrdam https://github.com/MitwRdam/MakeAIWork
```

</li>

<li>

Keep your fork repository up-todate by regularly pulling changes from the original remote repository into your local fork..

```bash
 git pull mitwrdam main
```

and push the changes to you remote fork 

```bash
git push
```

</li>

</ol>

### Enable [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about) (Windows only)
<ol>

<li>

**Check If Your Processor Supports [Virtualization](https://www.technorms.com/8208/check-if-processor-supports-virtualization)**

</li>

<li>

**Enable Windows Subsystem for Linux**

Enter the following command in Windows Powershell:
```pwsh
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

</li>

<li>

**Enable the Virtual Machine Platform feature (Windows only)**
Enter the following command in Windows Powershell:
```pwsh
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

</li>

<li>

**Make WSL 2 Default (Windows only)**
Enter the following command in Windows Powershell:
```pwsh
wsl –set-default-version 2
```

</li>

</ol>

### Install [Docker](https://learndocker.online/introduction/the-whats-and-whys/what-is-docker/) Desktop (Windows and MacOS)
To facilitate you with a managed portable [isolated](https://learndocker.online/introduction/the-whats-and-whys/what-are-containers/) [Development Environment]((https://learndocker.online/introduction/the-whats-and-whys/why-docker-for-devs)), we provide a Docker image in which all dependencies are preinstalled. We prefer Docker for isolation since it is a much lighter solution than [Virtual Machine](https://learndocker.online/introduction/the-whats-and-whys/containers-vs-vms/). 

<ol>

<li>

**Download and install [Docker Desktop](https://www.docker.com/get-started)**

<li>

**Configure Docker Desktop**
Open Docker Desktop, go to settings and select <i>Start when you login</i>
<br>
</li>

<li>

**Test your Docker installation**
Check if you are able to use Docker by running an example container in <b>(git) bash</b>
```sh
docker run hello-world
```

If that works, you can run the scripts to start the Docker container as described in section <u>Python AI Workspace Usage</u>.

</li>

<li>

**Install Python (Windows only)**
Although we use Docker as the Python workspace, we also install [python](https://www.python.org/downloads/release/python-3105/) on our host to be able to automatically start the webbrowser after Jupyter has been started.

</li>

</ol>

### Edit with Visual Studio Code
<ol>

<li>

Install [Visual Studio Code](https://code.visualstudio.com)

</li>

<li>

**Enable VSCode to be opened from the command line (macOS only)**

In VSCode, open the Command Palette and type 'shell command' in order to select the Shell command: Install ‘code’ command in PATH

</li>

<li>

**Start vscode with command from current directory**

Start a (git) bash shell and enter directory MakeAIWork, from there use the command <i>code</i> to start vscode.
```sh
cd MakeAIWork
code .
```

</li>

<li>

**Install the [Python extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python)**

</li>

<li>

**Install Live Share**

Follow the instructions at [Collaborate with Live Share](https://code.visualstudio.com/learn/collaboration/live-share)

</li>

</ol>

### Ubuntu in Windows sub-system (alternative for Windows users)
Instead of Git bash and Docker, you can install a complete Ubuntu terminal environment with Windows Subsystem for Linux (WSL). Although Ubuntu can be installed in minutes, you lack the benefit of all preinstalled Python modules in an isolated container. 

<ol>

<li>

Download and install [Ubuntu LTS on WSL2](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support#3-download-ubuntu)

</li>

<li>

Install pip

</li>

<li>

Install dependencies

</li>

<li>

Install Jupyterlab

</li>

</ol>

---

## Python AI Workspace Usage
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

<ul>

<li>

<b>REPL</b> (Read Evaluate Print Loop) modus to experimentally learn Python commands. Exit by pressing [Control+D].

```bash 
sh/python.sh
```

</li>

<li>

Start python with a <b>script</b> from directory <i>project</i>

```bash 
sh/python.sh scripts/lists/sum.py
```

</li>

<li>

Start <b>Jupyter Lab</b> to learn from the <i>notebooks</i> available at <i>project/notebooks</i>

```bash 
sh/jupyter.sh
```

</li>

<li>

Start container with an interactive <b>bash</b> (expert mode) to perform system operations

```sh
sh/bash.sh
```  

</li>

</ul>
  
### Docker artifacts
Each of the above scripts will call run/miw_container.sh which will spin up a container based on the latest version of 'jaboo/miw' which is either stored locally or will be fetched from available at [Dockerhub](https://hub.docker.com/repository/docker/jaboo/miw). 

Inspect locally stored images with
```sh
docker images
```

The containers will be removed automatically after being terminated. For overview of both running and terminated containers enter  
```sh
docker container ls -a
```

Removing images and/containers will not cause data loss. After removing the image, Docker will pull a new instance when you start a container. 
Docker images and containers can be removed (if not done automatically) by running
```sh
docker/clean_docker_artifacts.sh
```

---

### References
[How to Use Linux Terminal in Windows 10](https://allthings.how/how-to-use-linux-terminal-in-windows-10/)<br>
[Jupyter](https://jupyter.org/)
