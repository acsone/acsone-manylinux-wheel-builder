#!/bin/bash
set -e -x

MANYLINUX_VER=manylinux1_x86_64
DOCKER_IMAGE=quay.io/pypa/${MANYLINUX_VER}
PY_VER=cp27-cp27mu
REQS=$(ls requirements-*.txt)

./download.sh
docker run --rm -v `pwd`:/io $DOCKER_IMAGE /io/build-wheels.sh $PY_VER $REQS
ls wheelhouse/
