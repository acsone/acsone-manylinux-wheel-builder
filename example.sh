#!/bin/bash
set -e -x

DOCKER_IMAGE=quay.io/pypa/manylinux1_x86_64
PY_VER=cp27-cp27mu
REQS=$(ls requirements-*.txt)

./download.sh
docker run --rm -v `pwd`:/io $DOCKER_IMAGE /io/build-wheels.sh $PY_VER $REQS
ls wheelhouse/
