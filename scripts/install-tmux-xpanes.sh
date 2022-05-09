#/bin/bash
#

set -e

# Preparation for `tmux-xpanes`
add-apt-repository -y ppa:greymd/tmux-xpanes

apt-get update && \
    apt-get install -y \
        tmux \
        tmux-xpanes
