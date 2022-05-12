#/bin/bash
#

set -e

apt-get update && \
    apt-get install -y \
        curl \
        jq

_VERSION=$(curl -s -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/little-angry-clouds/kubernetes-binaries-managers/releases/latest" \
        | jq -r '.tag_name')

OS_NAME=$(uname | tr '[:upper:]' '[:lower:]')
OS_ARCH=$(dpkg --print-architecture)
_ARCHIVE_PATH=$(mktemp -d)
_ARCHIVE=$_ARCHIVE_PATH/helmenv-$OS_NAME-$OS_ARCH.tar.gz
_INSTALL_PATH=/usr/local/bin

curl -sL "https://github.com/little-angry-clouds/kubernetes-binaries-managers/releases/download/$_VERSION/helmenv-$OS_NAME-$OS_ARCH.tar.gz" \
    -o $_ARCHIVE

tar -C $_ARCHIVE_PATH -zxvf $_ARCHIVE helmenv-$OS_NAME-$OS_ARCH && \
    install -o root -g root -m 0755 $_ARCHIVE_PATH/helmenv-$OS_NAME-$OS_ARCH $_INSTALL_PATH/helmenv

tar -C $_ARCHIVE_PATH -zxvf $_ARCHIVE helm-wrapper-$OS_NAME-$OS_ARCH && \
    install -o root -g root -m 0755 $_ARCHIVE_PATH/helm-wrapper-$OS_NAME-$OS_ARCH $_INSTALL_PATH/helm
