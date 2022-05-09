#/bin/bash
#

set -e

apt-get remove --ignore-missing -f \
    docker \
    docker.io \
    containerd \
    runc

apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

DOCKER_ARCHIVE_KEYRING=/usr/share/keyrings/docker-archive-keyring.gpg
rm -f $DOCKER_ARCHIVE_KEYRING && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        | gpg --dearmor -o $DOCKER_ARCHIVE_KEYRING

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=$DOCKER_ARCHIVE_KEYRING] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
        | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update && \
    apt-get install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-compose-plugin

groupadd -f docker && \
    usermod -aG docker vagrant
