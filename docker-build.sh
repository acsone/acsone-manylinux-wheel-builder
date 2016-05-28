#!/bin/bash

DOCKER_IMAGE=quay.io/pypa/manylinux1_x86_64
PY_VER=cp27-cp27mu

./download.sh
docker run -e "PY_VER=$PY_VER" --rm -v `pwd`:/io $DOCKER_IMAGE /io/build-wheels.sh
ls wheelhouse/
