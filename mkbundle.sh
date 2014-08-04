#!/bin/bash

set -e

BASE_DIR=$(dirname $(readlink -f $0))

function on_exit() {
    [ -e "${TARBALL}" ] && rm "${TARBALL}"
}

VERSION=$(printf "%05d" ${BUILD_NUMBER:-$(date +%Y%m%d%H%M)})
PACKAGE=${PACKAGE:-zvm-zpipes}
TARBALL=${BASE_DIR}/${PACKAGE}-${VERSION}.tar.gz
trap on_exit exit

mkcbundle -p ${PACKAGE} -v ${VERSION}
mkdir -p /var/www/cbundles/${PACKAGE}
cp ${TARBALL} /var/www/cbundles/${PACKAGE}

echo ${VERSION} > /var/www/cbundles/${PACKAGE}/snapshot.txt
