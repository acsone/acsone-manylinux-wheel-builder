#!/bin/bash
exec 3>&1
special_echo () {
    echo "$@" >&3
}

exec &> /io/build-deps.log

set -e -x

source /etc/os-release

DOWNLOADS=/io/downloads

mkdir -p build
cd build

special_echo "some deb install..."

# postgresql for psycopg2
curl -sSL http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ ${VERSION_CODENAME}-pgdg main" > /etc/apt/sources.list.d/pgdg.list
apt-get -yq update
apt-get -y install libpq-dev

# openldap for python-openldap
apt-get install -y libldap2-dev libsasl2-dev

# recent cups
special_echo "cups"
rm -fr cups-*
tar zxvf $DOWNLOADS/cups.tgz
pushd cups-*
./configure --prefix=/usr/local
make
make install
popd

# recent libxml2 required for lxml
special_echo "libxml2"
rm -fr libxml2-*
tar zxf $DOWNLOADS/libxml2.tgz
pushd libxml2-*
./configure --without-python
make
make install
popd

# recent libxslt required for lxml
special_echo "libxslt"
rm -fr libxslt-*
tar zxf $DOWNLOADS/libxslt.tgz
pushd libxslt-*
./configure --without-python
make
make install
popd
