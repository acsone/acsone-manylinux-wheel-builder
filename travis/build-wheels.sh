#!/bin/bash
set -e -x
shopt -s nullglob

# Install system packages required by our libraries
yum install -y $(cat /io/rpms.txt)

# Enumerate all we need to build
cat \
  /io/requirements*.txt \
  | sort | uniq > /io/build-requirements.txt

# Compile wheels
rm -fr /io/wheelhouse/
rm -fr /io/wheelhouse.tmp/
PYBIN=/opt/python/${PY_VER}/bin
${PYBIN}/pip wheel -r /io/build-requirements.txt -w /io/wheelhouse.tmp/

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
