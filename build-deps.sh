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
yum install -y libtiff-devel libjpeg-devel libwebp-devel

# cffi required for cryptography
yum install -y libffi-devel

# recent cups
yum install -y cups-devel

# krb5 for postgres and openldap
yum install -y krb5-devel

# openldap for python-openldap
yum install -y openldap-devel

# postgresql for psycopg2
yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
yum -y install postgresql13-devel
ln -s /usr/pgsql-13/bin/pg_config /usr/local/bin/

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
