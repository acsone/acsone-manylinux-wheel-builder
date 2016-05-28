#!/bin/bash
set -e -x

DOWNLOADS=/io/downloads

mkdir -p build
cd build

# build tools
yum install -y groff

# libjpeg and libtiff required for Pillow
yum install -y libtiff-devel libjpeg-devel

# recent zlib
rm -fr zlib-*
tar zxvf $DOWNLOADS/zlib.tgz
pushd zlib-*
./configure --prefix=/usr/local
make
make install
popd

# recent openssl
rm -fr openssl-*
tar zxf $DOWNLOADS/openssl.tgz
pushd openssl-*
./config --prefix=/usr/local zlib shared
make
make install
popd

# recent cyrus-sasl
rm -fr cyrus-sasl-*
tar zxf $DOWNLOADS/cyrus-sasl.tgz
pushd cyrus-sasl-*
./configure --prefix=/usr/local
make
make install
popd

# recent krb5
rm -fr krb5-*
tar zxf $DOWNLOADS/krb5.tgz
pushd krb5-*/src
./configure --prefix=/usr/local
make
make install
popd

# recent openldap client
rm -fr openldap-*
tar zxf $DOWNLOADS/openldap.tgz
pushd openldap-*
./configure --prefix=/usr/local --enable-slapd=no --with-cyrus-sasl=yes
make depend
make
make install
# we need these symlink to build older version of python-ldap
pushd /usr/local/include
for f in sasl/*.h ; do ln -s $f ; done
popd
popd

# recent libpq for psycopg2
rm -fr postgres-*
tar zxf $DOWNLOADS/postgresql.tgz
pushd postgresql-*
./configure --prefix=/usr/local --without-readline --with-openssl --with-gssapi
sed -i 's,DEFAULT_PGSOCKET_DIR.*,DEFAULT_PGSOCKET_DIR "/var/run/postgresql",' ./src/include/pg_config_manual.h
make -C src/bin install
make -C src/include install || echo "ignoring error"
make -C src/interfaces install
popd

# recent libxml2 required for lxml
rm -fr libxml2-*
tar zxf $DOWNLOADS/libxml2.tgz
pushd libxml2-*
./configure --without-python
make
make install
popd

# recent libxslt required for lxml
rm -fr libxslt-*
tar zxf $DOWNLOADS/libxslt.tgz
pushd libxslt-*
./configure --without-python
make
make install
popd
