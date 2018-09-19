#!/bin/bash
set -e -x
rm -fr downloads
mkdir -p downloads
pushd downloads
# cups 2.2.8 does not build on this old images, do stick to 2.2.3
wget -nv https://github.com/apple/cups/releases/download/v2.2.3/cups-2.2.3-source.tar.gz -O cups.tgz
#wget -nv ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz -O cyrus-sasl.tgz
cp ../vendor/cyrus-sasl-2.1.26.tar.gz cyrus-sasl.tgz
wget -nv https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.46.tgz -O openldap.tgz
wget -nv https://zlib.net/zlib-1.2.11.tar.gz -O zlib.tgz
wget -nv https://web.mit.edu/kerberos/dist/krb5/1.16/krb5-1.16.1.tar.gz -O krb5.tgz
wget -nv https://www.openssl.org/source/openssl-1.0.2p.tar.gz -O openssl.tgz
wget -nv https://ftp.postgresql.org/pub/source/v9.6.10/postgresql-9.6.10.tar.gz -O postgresql.tgz
wget -nv https://github.com/GNOME/libxml2/archive/v2.9.8.tar.gz -O libxml2.tgz
wget -nv https://github.com/GNOME/libxslt/archive/v1.1.32.tar.gz -O libxslt.tgz
popd
