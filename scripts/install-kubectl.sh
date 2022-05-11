#/bin/bash
#

set -e

apt-get update && \
    apt-get install -y \
        curl

K8S_VERSION=$(curl -sL https://dl.k8s.io/release/stable.txt)
K8S_CHECKSUM=$(curl -sL "https://dl.k8s.io/$K8S_VERSION/bin/linux/amd64/kubectl.sha256")
K8S_BINARY=$(mktemp)

curl -sL "https://dl.k8s.io/release/$K8S_VERSION/bin/linux/amd64/kubectl" -o $K8S_BINARY

echo "$K8S_CHECKSUM  $K8S_BINARY" | sha256sum --check

install -o root -g root -m 0755 $K8S_BINARY /usr/local/bin/kubectl
