#!/bin/bash

secure_server "$SSUSER" "$SSPASSWORD" "$SSPUBKEY"
enable_passwordless_sudo "$SSUSER"

cp /root/.ssh/authorized_keys /home/$SSUSER/.ssh/authorized_keys
chown $SSUSER.$SSUSER -R /home/$SSUSER/.ssh

system_update
debian_upgrade

sudo apt-get install -y curl wget mc joe tmux p7zip-full libsm6 libxext6 libxrender-dev


su - $SSUSER
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda

~/miniconda/bin/conda init bash
source ~/.bashrc

conda create -n py37_trading2 python=3.7 tensorflow-gpu -y
conda activate py37_trading2
pip install plotly \
matplotlib \
pandas \
numpy \
gym \
tabulate \
gputil \
pathlib \
opencv-python \
dm-tree \
lz4 \
tensorflow \
https://ray-wheels.s3-us-west-2.amazonaws.com/master/780c1c3b08d473ffa42b232586dfdbc0a0af54af/ray-0.9.0.dev0-cp37-cp37m-manylinux1_x86_64.whl \
ray[tune] \
ray[rllib]

exit

mkdir -p /d
chmod a+rwX -R /d

all_set()
