#!/bin/bash
set -e -x
mkdir -p build
cd build

# zlib required by Pillow, psycopg2 and others
yum install -y zlib-devel

# libjpeg and libtiff required for Pillow
yum install -y libtiff-devel libjpeg-devel

# libyaml required for PyYAML
yum install -y libyaml-devel

# libpq for psycopg2
yum install -y libpqxx-devel

# ldap client libs for python-ldap
yum install -y openldap24-libs-devel

# recent libxml2 required for lxml
rm -fr libxml2-*
wget ftp://xmlsoft.org/libxml2/LATEST_LIBXML2 -O libxml2.tgz
tar zxvf libxml2.tgz
pushd libxml2-*
./configure --without-python
make
make install
popd

# recent libxslt required for lxml
rm -fr libxslt-*
wget ftp://xmlsoft.org/libxml2/LATEST_LIBXSLT -O libxslt.tgz
tar zxvf libxslt.tgz
pushd libxslt-*
./configure --without-python
make
make install
popd
