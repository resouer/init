#!/bin/bash

# Only work for root user
echo "This init shell only work for root (for Aliyun)"

# install golang
wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.5.1.linux-amd64.tar.gz

# install git
apt-get update
apt-get install -y git
git config --global user.name "Harry Zhang"
git config --global user.email "harryzhang@zju.edu.cn"

# write GOPATH
cat <<EOT >> /etc/profile
export PATH=\$PATH:/usr/local/go/bin
export GOPATH=\$HOME/gocode
EOT

# make golang take effect
source /etc/profile

# instal godep
go version
apt-get install -y mercurial
export GOPATH=$HOME/go-tools
mkdir -p $GOPATH
go get github.com/tools/godep

# set up workspace
export KPATH=$HOME/code/kubernetes
mkdir -p $KPATH/src/k8s.io/kubernetes
cd $KPATH/src/k8s.io/kubernetes
git clone https://github.com/zju-sel/kubernetes.git .
git remote add upstream 'https://github.com/kubernetes/kubernetes.git'

# write godep & KPATH
cat <<EOT >> /etc/profile
export GOPATH=\$GOPATH:\$HOME/go-tools

export KPATH=\$HOME/code/kubernetes
export GOPATH=\$KPATH:\$GOPATH

export PATH=$PATH:\$GOPATH/bin
EOT

source /etc/profile

# prepare cluster
apt-get install -y curl
curl -L  https://github.com/coreos/etcd/releases/download/v2.2.0/etcd-v2.2.0-linux-amd64.tar.gz -o etcd-v2.2.0-linux-amd64.tar.gz
tar xzvf etcd-v2.2.0-linux-amd64.tar.gz
cp etcd-v2.2.0-linux-amd64/etcd /usr/local/bin

# install docker
wget -qO- https://get.docker.com/ | sh
