#!/bin/bash
set -x

# Enumerate all we need to build
PY_VER=$1
shift
REQS=$@

echo PY_VER=$PY_VER
echo REQS=$REQS

/io/build-deps.sh
if [ $? -ne 0 ] ; then
  cat /io/build-deps.log
  exit 1
fi

set -e

PYBIN=/opt/python/${PY_VER}/bin

# https://github.com/pypa/packaging/issues/91
${PYBIN}/pip install -U "setuptools<34"

# Compile wheels
mkdir -p /io/cache
rm -fr /io/wheelhouse.tmp
for req in $REQS; do
  ${PYBIN}/pip wheel -r /io/$req -w /io/wheelhouse.tmp/ --cache-dir=/io/cache
done

# Copy platform-independent wheels
rm -fr /io/wheelhouse
mkdir -p /io/wheelhouse
rm -f /io/wheelhouse.tmp/pip-*.whl /io/wheelhouse.tmp/setuptools-*.whl
set +e ; mv -v -u -t /io/wheelhouse/ /io/wheelhouse.tmp/*-any.whl ; set -e

# Bundle external shared libraries into the wheels
for whl in $(ls /io/wheelhouse.tmp/*-linux_x86_64.whl); do
    auditwheel repair --plat $MANYLINUX_VER $whl -w /io/wheelhouse/
    rm $whl
done

# Some ready-to-use wheels we got from pypi that were not processed by auditwheel
set +e ; mv -v -u -t /io/wheelhouse/ /io/wheelhouse.tmp/*-${PY_VER}-manylinux*_x86_64.whl ; set -e
