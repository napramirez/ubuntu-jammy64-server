#/bin/bash
#

set -e

apt-get update && \
    apt-get install -y \
        curl \
        jq \
        unzip

KUBELOGIN_VERSION=$(curl -s -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/Azure/kubelogin/releases/latest" \
        | jq -r '.tag_name')

OS_NAME=$(uname | tr '[:upper:]' '[:lower:]')
OS_ARCH=$(dpkg --print-architecture)
KUBELOGIN_ARCHIVE=$(mktemp)
KUBELOGIN_ARCHIVE_EXTRACTION_PATH=$(mktemp -d)
KUBELOGIN_INSTALL_PATH=/usr/local/bin

curl -sL "https://github.com/Azure/kubelogin/releases/download/$KUBELOGIN_VERSION/kubelogin-$OS_NAME-$OS_ARCH.zip" \
    -o $KUBELOGIN_ARCHIVE

unzip $KUBELOGIN_ARCHIVE -d $KUBELOGIN_ARCHIVE_EXTRACTION_PATH

install -o root -g root -m 0755 $KUBELOGIN_ARCHIVE_EXTRACTION_PATH/bin/${OS_NAME}_$OS_ARCH/kubelogin $KUBELOGIN_INSTALL_PATH/kubelogin
