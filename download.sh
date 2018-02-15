#!/bin/bash
set -e -x
rm -fr downloads
mkdir downloads
pushd downloads
wget -nv https://github.com/apple/cups/releases/download/v2.2.3/cups-2.2.3-source.tar.gz -O cups.tgz
wget -nv ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz -O cyrus-sasl.tgz
wget -nv ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.44.tgz -O openldap.tgz
wget -nv http://zlib.net/zlib-1.2.11.tar.gz -O zlib.tgz
wget -nv http://web.mit.edu/kerberos/dist/krb5/1.14/krb5-1.14.3.tar.gz -O krb5.tgz
wget -nv https://www.openssl.org/source/openssl-1.0.2k.tar.gz -O openssl.tgz
wget -nv https://ftp.postgresql.org/pub/source/v9.6.2/postgresql-9.6.2.tar.gz -O postgresql.tgz
wget -nv ftp://xmlsoft.org/libxml2/LATEST_LIBXML2 -O libxml2.tgz
wget -nv ftp://xmlsoft.org/libxml2/LATEST_LIBXSLT -O libxslt.tgz
popd
