#!/bin/bash
set -e -x
rm -fr downloads
mkdir -p downloads
pushd downloads
wget -nv https://github.com/apple/cups/releases/download/v2.3.3/cups-2.3.3-source.tar.gz -O cups.tgz
wget -nv http://xmlsoft.org/sources/libxml2-2.9.10.tar.gz -O libxml2.tgz
wget -nv http://xmlsoft.org/sources/libxslt-1.1.34.tar.gz -O libxslt.tgz
popd
