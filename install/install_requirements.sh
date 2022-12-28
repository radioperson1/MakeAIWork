#!/usr/bin/env bash

# Detect OS
unameOut="$(uname -s)"
os="${unameOut:0:7}"
case "${os}" in
    Linux*)     
      machine="Linux"
      # sudo dnf install freeglut
    ;;
    Darwin*)
      machine="Mac"
      brew update && brew install freeglut
      export LIBGL_ALLOW_SOFTWARE=1
    ;;
    CYGWIN*)    machine="Cygwin";;
    MINGW*)     machine="Git Bash";;
    *)          machine="UNKNOWN:${os}"
esac

function install_with_conda {
  if (! command -v "conda" &> /dev/null ) then
    echo "Install Miniconda first!" && exit 0
  fi

  conda install --yes -c conda-forge \
    beautifulsoup4 \
    py-cpuinfo \
    jupyter_core \
    jupyterlab \
    keras \
    Keras-Preprocessing \
    lidar \
    matplotlib-base \
    matplotlib-venn \
    pandas \
    Pillow \
    pyopengl \
    pyspark \
    pytables \
    scikit-image \
    scikit-learn \
    scipy \
    seaborn \
    selenium \
    sqlite \
    tensorflow=2.8 \
    tensorboard-plugin-wit \
    tensorflow-estimator \
    widgetsnbextension
}

# Install all required libraries t
function install_with_pip {
  # Upgrade pip
  python3 -m pip install --upgrade pip

  # Install setuptools
  python3 -m pip install setuptools
  python3 -m pip install --no-cache-dir -r install/pip/requirements.txt

}

install_with_conda
#install_with_pip
