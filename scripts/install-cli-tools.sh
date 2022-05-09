#/bin/bash
#

set -e

# Preparation for `yq`
add-apt-repository -y ppa:rmescandon/yq

apt-get update \
    && apt-get install -y \
        gitk \
        tree \
        jq \
        yq
