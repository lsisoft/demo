#!/bin/bash

secure_server "$SSUSER" "$SSPASSWORD" "$SSPUBKEY"
enable_passwordless_sudo "$SSUSER"

cp /root/.ssh/authorized_keys /home/$SSUSER/.ssh/authorized_keys
chown $SSUSER.$SSUSER -R /home/$SSUSER/.ssh

system_update
debian_upgrade

sudo apt-get install -y curl wget mc joe tmux p7zip-full libsm6 libxext6 libxrender-dev

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda

#Install the NVIDIA Machine Learning network repository installation package.
os=ubuntu1804
wget https://developer.download.nvidia.com/compute/machine-learning/repos/${os}/x86_64/nvidia-machine-learning-repo-${os}_1.0.0-1_amd64.deb

sudo dpkg -i nvidia-machine-learning-repo-*.deb
sudo apt-get update
# Install the TensorRT package that fits your particular needs.
# For only running TensorRT C++ applications:
sudo apt-get install libnvinfer7 libnvonnxparsers7 libnvparsers7 libnvinfer-plugin7
# For also building TensorRT C++ applications:
sudo apt-get install libnvinfer-dev libnvonnxparsers-dev
 libnvparsers-dev libnvinfer-plugin-dev
# For running TensorRT Python applications:
sudo apt-get install python-libnvinfer python3-libnvinfer

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
