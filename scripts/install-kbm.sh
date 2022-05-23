#/bin/bash
#

set -e

apt-get update && \
    apt-get install -y \
        curl \
        jq

KBM_VERSION=$(curl -s -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/little-angry-clouds/kubernetes-binaries-managers/releases/latest" \
        | jq -r '.tag_name')
KBM_VERSION_NUMBER=$(echo $KBM_VERSION | awk -Fv '{print $2}')

OS_NAME=$(uname | tr '[:upper:]' '[:lower:]')
OS_ARCH=$(dpkg --print-architecture)
KBM_ARCHIVE_PATH=$(mktemp -d)
KBM_ARCHIVE=$KBM_ARCHIVE_PATH/kubernetes-binaries-managers_${KBM_VERSION_NUMBER}_${OS_NAME}_$OS_ARCH.tar.gz
KBM_INSTALL_PATH=/usr/local/bin

curl -sL "https://github.com/little-angry-clouds/kubernetes-binaries-managers/releases/download/$KBM_VERSION/kubernetes-binaries-managers_${KBM_VERSION_NUMBER}_${OS_NAME}_$OS_ARCH.tar.gz" \
    -o $KBM_ARCHIVE

tar -C $KBM_ARCHIVE_PATH -zxvf $KBM_ARCHIVE kubectl-$OS_NAME-$OS_ARCH/kbenv && \
    install -o root -g root -m 0755 $KBM_ARCHIVE_PATH/kubectl-$OS_NAME-$OS_ARCH/kbenv $KBM_INSTALL_PATH/kbenv

tar -C $KBM_ARCHIVE_PATH -zxvf $KBM_ARCHIVE kubectl-$OS_NAME-$OS_ARCH/kubectl-wrapper && \
    install -o root -g root -m 0755 $KBM_ARCHIVE_PATH/kubectl-$OS_NAME-$OS_ARCH/kubectl-wrapper $KBM_INSTALL_PATH/kubectl

tar -C $KBM_ARCHIVE_PATH -zxvf $KBM_ARCHIVE helm-$OS_NAME-$OS_ARCH/helmenv && \
    install -o root -g root -m 0755 $KBM_ARCHIVE_PATH/helm-$OS_NAME-$OS_ARCH/helmenv $KBM_INSTALL_PATH/helmenv

tar -C $KBM_ARCHIVE_PATH -zxvf $KBM_ARCHIVE helm-$OS_NAME-$OS_ARCH/helm-wrapper && \
    install -o root -g root -m 0755 $KBM_ARCHIVE_PATH/helm-$OS_NAME-$OS_ARCH/helm-wrapper $KBM_INSTALL_PATH/helm
