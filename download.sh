#!/bin/bash
set -e -x
rm -fr downloads
mkdir downloads
pushd downloads
curl -sS https://github.com/apple/cups/releases/download/v2.2.8/cups-2.2.8-source.tar.gz -o cups.tgz
#curl -sS ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz -o cyrus-sasl.tgz
curl -sS https://github.com/cyrusimap/cyrus-sasl/archive/cyrus-sasl-2.1.27-rc7.tar.gz -o cyrus-sasl.tgz
curl -sS https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.4.46.tgz -o openldap.tgz
curl -sS https://zlib.net/zlib-1.2.11.tar.gz -o zlib.tgz
curl -sS https://web.mit.edu/kerberos/dist/krb5/1.16/krb5-1.16.1.tar.gz -o krb5.tgz
curl -sS https://www.openssl.org/source/openssl-1.0.2p.tar.gz -o openssl.tgz
curl -sS https://ftp.postgresql.org/pub/source/v9.6.10/postgresql-9.6.10.tar.gz -o postgresql.tgz
curl -sS https://github.com/GNOME/libxml2/archive/v2.9.8.tar.gz -o libxml2.tgz
curl -sS https://github.com/GNOME/libxslt/archive/v1.1.32.tar.gz -o libxslt.tgz
popd
