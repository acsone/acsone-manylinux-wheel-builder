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

# since CentOS 5 is obsolete, use the vault repo
sed -i'' -e 's/^mirrorlist/#mirrorlist/' -e 's,^#baseurl=http://mirror.centos.org,baseurl=http://vault.centos.org,' /etc/yum.repos.d/CentOS-Base.repo

# cups-devel required by pycups
yum install -y cups-devel

# build tools
yum install -y groff

# libjpeg and libtiff required for Pillow
yum install -y libtiff-devel libjpeg-devel

# cffi required for cryptography
yum install -y libffi-devel

# recent zlib
special_echo "zlib"
rm -fr zlib-*
tar zxvf $DOWNLOADS/zlib.tgz
pushd zlib-*
./configure --prefix=/usr/local
make
make install
popd

# recent openssl
special_echo "openssl"
rm -fr openssl-*
tar zxf $DOWNLOADS/openssl.tgz
pushd openssl-*
./config --prefix=/usr/local zlib shared
make
make install
popd

# recent cyrus-sasl
special_echo "cyrus-sasl"
rm -fr cyrus-sasl-*
tar zxf $DOWNLOADS/cyrus-sasl.tgz
pushd cyrus-sasl-*
./configure --prefix=/usr/local
make
make install
popd

# recent krb5
special_echo "krb5"
rm -fr krb5-*
tar zxf $DOWNLOADS/krb5.tgz
pushd krb5-*/src
./configure --prefix=/usr/local
make
make install
popd

# recent openldap client
special_echo "openldap"
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
special_echo "postgres"
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
