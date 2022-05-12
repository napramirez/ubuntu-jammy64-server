#/bin/bash
#

set -e

apt-get update && \
    apt-get install -y \
        curl \
        jq

HELMENV_VERSION=$(curl -s -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/little-angry-clouds/kubernetes-binaries-managers/releases/latest" \
        | jq -r '.tag_name')

OS_NAME=$(uname | tr '[:upper:]' '[:lower:]')
OS_ARCH=$(dpkg --print-architecture)
HELMENV_ARCHIVE_PATH=$(mktemp -d)
HELMENV_ARCHIVE=$HELMENV_ARCHIVE_PATH/helmenv-$OS_NAME-$OS_ARCH.tar.gz
HELMENV_INSTALL_PATH=/usr/local/bin

curl -sL "https://github.com/little-angry-clouds/kubernetes-binaries-managers/releases/download/$HELMENV_VERSION/helmenv-$OS_NAME-$OS_ARCH.tar.gz" \
    -o $HELMENV_ARCHIVE

tar -C $HELMENV_ARCHIVE_PATH -zxvf $HELMENV_ARCHIVE helmenv-$OS_NAME-$OS_ARCH && \
    install -o root -g root -m 0755 $HELMENV_ARCHIVE_PATH/helmenv-$OS_NAME-$OS_ARCH $HELMENV_INSTALL_PATH/helmenv

tar -C $HELMENV_ARCHIVE_PATH -zxvf $HELMENV_ARCHIVE helm-wrapper-$OS_NAME-$OS_ARCH && \
    install -o root -g root -m 0755 $HELMENV_ARCHIVE_PATH/helm-wrapper-$OS_NAME-$OS_ARCH $HELMENV_INSTALL_PATH/helm
