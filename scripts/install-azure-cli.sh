#/bin/bash
#

set -e

apt-get update && \
    apt-get install -y \
        ca-certificates \
        curl \
        apt-transport-https \
        lsb-release \
        gnupg

MICROSOFT_ARCHIVE_KEYRING=/etc/apt/trusted.gpg.d/microsoft.gpg
rm -f $MICROSOFT_ARCHIVE_KEYRING && \
    curl -sL https://packages.microsoft.com/keys/microsoft.asc \
        | gpg --dearmor -o $MICROSOFT_ARCHIVE_KEYRING

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=$MICROSOFT_ARCHIVE_KEYRING] \
    https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" \
        | tee /etc/apt/sources.list.d/azure-cli.list > /dev/null

apt-get update && \
    apt-get install -y \
        azure-cli
