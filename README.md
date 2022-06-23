# MakeAIWork

## Projects

This repository contains sources to be used by python students. There are three project directories (project_1, project_2, project_3), each containing:
<ul>
<li>cursus_materiaal</li> with the project description
<li>notebooks</li> containing Jupyter notebooks for reference
<li>python</li> containing Python scripts of the student aswell as example scripts
</ul>

## Python AI Workspace

Students use a containerised Python environment running the [Docker](https://www.docker.com/) image 'jaboo/miw' available at [Dockerhub](https://hub.docker.com/repository/docker/jaboo/miw). The project files are accessible in the containerised runtime environment by means of a dynamic mount. For example, when the latest version of the image is 0.2 then the studentname $STUDENT used in the container is stud02 and the home directory $HOME is <i>/home/stud02</i> which will be mounted to the host directory $PWD/project.
<br>

### Start a Python container
Python can run in different modi:
<ul>

<li>
<b>REPL</b> (Read Evaluate Print Loop) modus to experimentally learn Python commands. Exit by pressing [Control+D].

```bash 
run/python.sh
```
</li>

<li>
Start python with a <b>script</b>

```bash 
run/python.sh examples/sum.py
```
</li>
Start <b>Jupyter Server</b> to learn from the <i>notebooks</i> available at <i>$PROJECT/notebooks</i>

```bash 
run/jupyter.sh
```
<li>
Start container with an interactive <b>bash</b> (expert mode) to perform system operations

```bash
run/bash.sh
```
</li>

</ul>

## References
[Jupyter](https://jupyter.org/)
