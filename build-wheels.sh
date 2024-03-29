#!/bin/bash
set -x

source /etc/os-release

# Enumerate all we need to build
PY_VER=$1
shift
PRE_INSTALL=$1
shift
MANYLINUX_VER=$1
shift
REQS=$@

echo PY_VER=$PY_VER
echo PRE_INSTALL=$PRE_INSTALL
echo MANYLINUX_VER=$MANYLINUX_VER
echo REQS=$REQS

/io/build-deps-${ID}.sh
if [ $? -ne 0 ] ; then
  cat /io/build-deps.log
  exit 1
fi

set -e

PYBIN=/opt/python/${PY_VER}/bin

${PYBIN}/pip install -U ${PRE_INSTALL}

# Static linking for xmlsec: https://github.com/mehcode/python-xmlsec/issues/157#issuecomment-693254958
export PYXMLSEC_STATIC_DEPS=1
# workaround xmlssec static build issue: https://gitlab.gnome.org/GNOME/libxslt/-/issues/52
# should be solved with libxslt 1.1.35
export PYXMLSEC_LIBXML2_VERSION=2.9.10
export PYXMLSEC_ZLIB_VERSION=1.2.12

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
