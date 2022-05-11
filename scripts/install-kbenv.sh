#/bin/bash
#

set -e

apt-get update && \
    apt-get install -y \
        curl \
        jq

KBENV_VERSION=$(curl -s -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/little-angry-clouds/kubernetes-binaries-managers/releases/latest" \
        | jq -r '.tag_name')

OS_NAME=$(uname | tr '[:upper:]' '[:lower:]')
OS_ARCH=$(dpkg --print-architecture)
KBENV_ARCHIVE_PATH=$(mktemp -d)
KBENV_ARCHIVE=$KBENV_ARCHIVE_PATH/kbenv-$OS_NAME-$OS_ARCH.tar.gz
KBENV_INSTALL_PATH=/usr/local/bin

curl -sL "https://github.com/little-angry-clouds/kubernetes-binaries-managers/releases/download/$KBENV_VERSION/kbenv-$OS_NAME-$OS_ARCH.tar.gz" \
    -o $KBENV_ARCHIVE

tar -C $KBENV_ARCHIVE_PATH -zxvf $KBENV_ARCHIVE kbenv-$OS_NAME-$OS_ARCH && \
    install -o root -g root -m 0755 $KBENV_ARCHIVE_PATH/kbenv-$OS_NAME-$OS_ARCH $KBENV_INSTALL_PATH/kbenv

tar -C $KBENV_ARCHIVE_PATH -zxvf $KBENV_ARCHIVE kubectl-wrapper-$OS_NAME-$OS_ARCH && \
    install -o root -g root -m 0755 $KBENV_ARCHIVE_PATH/kubectl-wrapper-$OS_NAME-$OS_ARCH $KBENV_INSTALL_PATH/kubectl
