#!/bin/bash
set -e -x

# Install system packages required by our libraries
# TODO

# Enumerate all we need to build
cat \
  /io/requirements-oca.txt \
  | sort | uniq > /io/requirements.txt

# Compile wheels
PYBIN=/opt/python/${PY_VER}/bin
${PYBIN}/pip wheel -r /io/requirements.txt -w /tmp/wheelhouse/

# Bundle external shared libraries into the wheels
mkdir /io/wheelhouse
cp -a /tmp/wheelhouse/*.whl /io/wheelhouse
for whl in /tmp/wheelhouse/*-${PY_VER}-linux_$(uname -i).whl; do
    auditwheel repair $whl -w /io/wheelhouse/
done
