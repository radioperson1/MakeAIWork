#!/usr/bin/env bash

version="3.10.5"
package="Python-${version}"
tarfile="${package}.tar.xz"

echo "Download ${tarfile}"
# https://www.python.org/ftp/python/3.10.5/
wget https://www.python.org/ftp/python/${version}/${tarfile}

printf "Extract %s\n" ${package}
tar -xf ${tarfile}

printf "Install %s\n" ${tarfile}
(cd ${package}; ./configure --enable-optimizations && make)

echo "Link command python to python3"
(cd /usr/bin/; ln -s python3 python)

echo "Clean installation files"

rm_cmd="rm -rf ${tarfile}"
echo ${rm_cmd}
eval ${rm_cmd}

rm_cmd="rm -rf ${package}"
echo ${rm_cmd}
eval ${rm_cmd}

python --version