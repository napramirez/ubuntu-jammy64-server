#/bin/bash
#

set -e

apt-get update && \
    apt-get install -y \
        curl \
        jq

SOPS_VERSION=$(curl -s -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/mozilla/sops/releases/latest" \
        | jq -r '.tag_name')

OS_NAME=$(uname | tr '[:upper:]' '[:lower:]')
OS_ARCH=$(dpkg --print-architecture)
SOPS_ARCHIVE=$(mktemp)
SOPS_INSTALL_PATH=/usr/local/bin

curl -sL "https://github.com/mozilla/sops/releases/download/$SOPS_VERSION/sops-$SOPS_VERSION.$OS_NAME.$OS_ARCH" \
    -o $SOPS_ARCHIVE

install -o root -g root -m 0755 $SOPS_ARCHIVE $SOPS_INSTALL_PATH/sops
