#!/bin/bash
set -e -x
shopt -s nullglob

# Enumerate all we need to build
REQS=$(ls /io/requirements-*.txt)

/io/build-deps.sh

source /io/build-env.sh

# Compile wheels
rm -fr /io/wheelhouse/
rm -fr /io/wheelhouse.tmp/
PYBIN=/opt/python/${PY_VER}/bin
for req in $REQS; do
  ${PYBIN}/pip wheel -r $req -w /io/wheelhouse.tmp/
done

# Copy platform-independent wheels
mkdir /io/wheelhouse
mv /io/wheelhouse.tmp/*-any.whl /io/wheelhouse/

# Bundle external shared libraries into the wheels
for whl in /io/wheelhouse.tmp/*-linux_$(uname -i).whl; do
    auditwheel repair $whl -w /io/wheelhouse/
    rm $whl
done

# Should be empty if all wheels have been processed
rmdir /io/wheelhouse.tmp || ls /io/wheelhouse.tmp && exit 1

rm /io/wheelhouse/pip-*.whl /io/wheelhouse/setuptools-*.whl
