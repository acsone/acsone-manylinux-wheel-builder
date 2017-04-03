#!/bin/bash
set -x
shopt -s nullglob

# Enumerate all we need to build
PY_VER=$1
shift
REQS=$@

echo PYVER=$PY_VER
echo REQS=$REQS

/io/build-deps.sh
if [ $? -ne 0 ] ; then
  cat /io/build-deps.log
  exit 1
fi

set -e

# Compile wheels
mkdir -p /io/cache
rm -fr /io/wheelhouse.tmp
PYBIN=/opt/python/${PY_VER}/bin
for req in $REQS; do
  ${PYBIN}/pip wheel -r /io/$req -w /io/wheelhouse.tmp/ --cache-dir=/io/cache
done

# Copy platform-independent wheels
rm -fr /io/wheelhouse
mkdir -p /io/wheelhouse
rm -f /io/wheelhouse.tmp/pip-*.whl /io/wheelhouse.tmp/setuptools-*.whl
mv /io/wheelhouse.tmp/*-any.whl /io/wheelhouse/

# Bundle external shared libraries into the wheels
for whl in /io/wheelhouse.tmp/*-linux_$(uname -i).whl; do
    auditwheel repair $whl -w /io/wheelhouse/
    rm $whl
done
