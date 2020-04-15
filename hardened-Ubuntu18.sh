#!/bin/bash
#
#
#<UDF name="ssuser" Label="Sudo user username?" example="username" />
#<UDF name="sspassword" Label="Sudo user password?" example="strongPassword" />
#<UDF name="sspubkey" Label="SSH pubkey (installed for root and sudo user)?" example="ssh-rsa ..." />

# include StackScript Bash Library
source <ssinclude StackScriptID=1>

system_update
debian_upgrade

secure_server "$SSUSER" "$SSPASSWORD" "$SSPUBKEY"

cp /root/.ssh/authorized_keys /home/$SSUSER/.ssh/authorized_keys
chown $SSUSER.$SSUSER -R /home/$SSUSER/.ssh

su $SSUSER
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

conda init bash
conda create -n py37_trading2 python=3.7 tensorflow-gpu
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

all_set()
