#!/bin/bash

# Only work for root user
echo "This init shell only work for root (for Aliyun, Ucloud)"

# install golang
wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.5.1.linux-amd64.tar.gz

# install git
apt-get update
apt-get install -y git
git config --global user.name "Harry Zhang"
git config --global user.email "harryzhang@zju.edu.cn"

# install vimrc
git clone git://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_basic_vimrc.sh

# write GOPATH
cat <<EOT >> $HOME/.bashrc
export PATH=\$PATH:/usr/local/go/bin
EOT

# make golang take effect
source $HOME/.bashrc

# set up workspace
export KPATH=$HOME/code/kubernetes
mkdir -p $KPATH/src/k8s.io/kubernetes
cd $KPATH/src/k8s.io/kubernetes
git clone https://github.com/zju-sel/kubernetes.git .
git remote add upstream 'https://github.com/kubernetes/kubernetes.git'

# write godep & KPATH
cat <<EOT >> $HOME/.bashrc

export KPATH=\$HOME/code/kubernetes
export GOPATH=\$KPATH

export PATH=\$PATH:\$GOPATH/bin
EOT

source $HOME/.bashrc

# instal godep
go version
apt-get install -y mercurial
go get github.com/tools/godep

# prepare cluster
cd $HOME
apt-get install -y curl gcc
curl -L  https://github.com/coreos/etcd/releases/download/v2.2.0/etcd-v2.2.0-linux-amd64.tar.gz -o etcd-v2.2.0-linux-amd64.tar.gz
tar xzvf etcd-v2.2.0-linux-amd64.tar.gz
cp etcd-v2.2.0-linux-amd64/etcd /usr/local/bin

# install docker
wget -qO- https://get.docker.com/ | sh

# download kubelet
wget https://github.com/resouer/init/raw/master/kubectl -O $HOME/kubectl

# add git prompt
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/v2.3.2/contrib/completion/git-prompt.sh
