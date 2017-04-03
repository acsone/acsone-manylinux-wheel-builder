#!/bin/bash
set -e -x
rm -fr downloads
mkdir downloads
pushd downloads
wget ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz -O cyrus-sasl.tgz
wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.44.tgz -O openldap.tgz
wget http://zlib.net/zlib-1.2.11.tar.gz -O zlib.tgz
wget http://web.mit.edu/kerberos/dist/krb5/1.14/krb5-1.14.3.tar.gz -O krb5.tgz
wget https://www.openssl.org/source/openssl-1.0.2k.tar.gz -O openssl.tgz
wget https://ftp.postgresql.org/pub/source/v9.6.2/postgresql-9.6.2.tar.gz -O postgresql.tgz
wget ftp://xmlsoft.org/libxml2/LATEST_LIBXML2 -O libxml2.tgz
wget ftp://xmlsoft.org/libxml2/LATEST_LIBXSLT -O libxslt.tgz
popd
