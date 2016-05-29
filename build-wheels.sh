#!/bin/bash
set -e -x
shopt -s nullglob

# Enumerate all we need to build
PY_VER=$1
shift
REQS=$@

echo PYVER=$PY_VER
echo REQS=$REQS
mkdir /io/wheelhouse
exit 1

/io/build-deps.sh

# Compile wheels
mkdir -p /io/cache
rm -fr /io/wheelhouse.tmp
PYBIN=/opt/python/${PY_VER}/bin
for req in $REQS; do
  ${PYBIN}/pip wheel -r $req -w /io/wheelhouse.tmp/ --cache-dir=/io/cache
done

# Copy platform-independent wheels
rm -fr /io/wheelhouse
mkdir -p /io/wheelhouse
mv /io/wheelhouse.tmp/*-any.whl /io/wheelhouse/

# Bundle external shared libraries into the wheels
for whl in /io/wheelhouse.tmp/*-linux_$(uname -i).whl; do
    auditwheel repair $whl -w /io/wheelhouse/
    rm $whl
done

rm /io/wheelhouse/pip-*.whl /io/wheelhouse/setuptools-*.whl

# Should be empty if all wheels have been processed
rmdir /io/wheelhouse.tmp || ls /io/wheelhouse.tmp && exit 1
