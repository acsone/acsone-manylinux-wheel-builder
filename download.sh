#!/bin/bash
set -e -x
rm -fr downloads
mkdir -p downloads
pushd downloads
# cups 2.2.8+ does not build on this old images, do stick to 2.2.3
wget -nv https://github.com/apple/cups/releases/download/v2.2.3/cups-2.2.3-source.tar.gz -O cups.tgz
#wget -nv ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz -O cyrus-sasl.tgz
cp ../vendor/cyrus-sasl-2.1.26.tar.gz cyrus-sasl.tgz
wget -nv https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.46.tgz -O openldap.tgz
wget -nv https://zlib.net/zlib-1.2.11.tar.gz -O zlib.tgz
wget -nv https://web.mit.edu/kerberos/dist/krb5/1.16/krb5-1.16.1.tar.gz -O krb5.tgz
wget -nv https://www.openssl.org/source/openssl-1.1.1g.tar.gz -O openssl.tgz
wget -nv https://ftp.postgresql.org/pub/source/v12.3/postgresql-12.3.tar.gz -O postgresql.tgz
wget -nv http://xmlsoft.org/sources/libxml2-2.9.9.tar.gz -O libxml2.tgz
wget -nv http://xmlsoft.org/sources/libxslt-1.1.33.tar.gz -O libxslt.tgz
popd
