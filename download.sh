#!/bin/bash
set -e -x
rm -fr downloads
mkdir -p downloads
pushd downloads
wget -nv http://xmlsoft.org/sources/libxml2-2.9.12.tar.gz -O libxml2.tgz
wget -nv http://xmlsoft.org/sources/libxslt-1.1.34.tar.gz -O libxslt.tgz
popd
