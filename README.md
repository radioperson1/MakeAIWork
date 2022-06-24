# MakeAIWork

## Projects

This repository contains sources to be used by python students. Directory <i>project</i> contains the (re)sources:
<ul>
<li>p1, p2 and p3</i> containing
<i>cursus_materiaal</i> with a project description
<li>notebooks</li> containing Jupyter notebooks for reference
<li>scripts</li> with some example Python scripts 
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
./python.sh
```
</li>

<li>
Start python with a <b>script</b> from directory <i>project</i>

```bash 
./python.sh scripts/lists/sum.py
```
</li>
Start <b>Jupyter Server</b> to learn from the <i>notebooks</i> available at <i>project/notebooks</i>

```bash 
./jupyter.sh
```
<li>
Start container with an interactive <b>bash</b> (expert mode) to perform system operations

```bash
./bash.sh
```
</li>
    
</ul>

## References
[Jupyter](https://jupyter.org/)
