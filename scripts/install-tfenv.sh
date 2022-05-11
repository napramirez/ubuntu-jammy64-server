#/bin/bash
#

set -e

apt-get update && \
    apt-get install -y \
        git \
        unzip

export TFENV_USER=vagrant
export TFENV_INSTALL_PATH=/home/$TFENV_USER/.tfenv

rm -rf $TFENV_INSTALL_PATH && \
    sudo -u $TFENV_USER git clone https://github.com/tfutils/tfenv.git $TFENV_INSTALL_PATH


sudo -u $TFENV_USER mkdir -p /home/$TFENV_USER/bin

rm -f /home/$TFENV_USER/bin/tfenv && \
    sudo -u $TFENV_USER ln -s $TFENV_INSTALL_PATH/bin/tfenv /home/$TFENV_USER/bin

rm -f /home/$TFENV_USER/bin/terraform && \
    sudo -u $TFENV_USER ln -s $TFENV_INSTALL_PATH/bin/terraform /home/$TFENV_USER/bin
