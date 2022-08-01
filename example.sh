#!/bin/bash
set -e -x

MANYLINUX_VER=manylinux_2_24_x86_64
DOCKER_IMAGE=quay.io/pypa/${MANYLINUX_VER}
PY_VER=cp310-cp310
PRE_INSTALL=setuptools
REQS="requirements3-other.txt requirements3-latest.txt requirements3-oca.txt requirements3-odoo15.txt requirements3-odoomaster.txt"

#./download.sh
podman run --rm -v `pwd`:/io $DOCKER_IMAGE /io/build-wheels.sh $PY_VER "$PRE_INSTALL" $MANYLINUX_VER $REQS
ls wheelhouse/
