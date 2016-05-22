#!/bin/bash
set -e -x

# Install system packages required by our libraries
# TODO

# We build for these python versions
PYABITAGS="cp27-cp27mu"

# Enumerate all we need to build
REQS=/io/requirements.txt
cat \
  /io/requirements-oca.txt \
  | sort | uniq > $REQS

# Compile wheels
for PYABITAG in $PYABITAGS; do
    PYBIN=/opt/python/$PYABITAG/bin
    ${PYBIN}/pip wheel -r $REQS -w /io/wheelhouse/
done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/*.whl; do
    auditwheel repair $whl -w /io/wheelhouse/
done
