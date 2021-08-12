#!/bin/bash
exec 3>&1
special_echo () {
    echo "$@" >&3
}

exec &> /io/build-deps.log

set -e -x

DOWNLOADS=/io/downloads

mkdir -p build
cd build

special_echo "some yum install..."

# build tools
yum install -y groff

# ubiquitous zlib and openssl
yum install -y zlib-devel openssl-devel

# libjpeg and libtiff required for Pillow
yum install -y libtiff-devel libjpeg-devel

# cffi required for cryptography
yum install -y libffi-devel

# krb5 for postgres and openldap
yum install -y krb5-devel

# openldap for python-openldap
yum install -y openldap-devel

# postgresql for psycopg2
yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
yum -y install postgresql13-devel
ln -s /usr/pgsql-13/bin/pg_config /usr/local/bin/

# xmlsec build dependencies
yum install -y xmlsec1-devel xmlsec1-openssl-devel libtool-ltdl-devel

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
