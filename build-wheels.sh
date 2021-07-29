#!/bin/bash
set -x

# Enumerate all we need to build
PY_VER=$1
shift
MANYLINUX_VER=$1
shift
REQS=$@

echo PY_VER=$PY_VER
echo MANYLINUX_VER=$MANYLINUX_VER
echo REQS=$REQS

/io/build-deps.sh
if [ $? -ne 0 ] ; then
  cat /io/build-deps.log
  exit 1
fi

set -e

PYBIN=/opt/python/${PY_VER}/bin

# Compile wheels
mkdir -p /io/cache
rm -fr /io/wheelhouse.tmp
for req in $REQS; do
  ${PYBIN}/pip wheel -r /io/$req -w /io/wheelhouse.tmp/ --cache-dir=/io/cache
done

rm -fr /io/wheelhouse
mkdir -p /io/wheelhouse

# Bundle external shared libraries into the wheels
for whl in $(ls /io/wheelhouse.tmp/*-linux_x86_64.whl); do
    auditwheel repair --plat $MANYLINUX_VER $whl -w /io/wheelhouse/
done
