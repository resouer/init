#!/bin/bash

# install golang
wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.5.1.linux-amd64.tar.gz

# install git
apt-get update
apt-get install -y git
git config --global user.name "Harry Zhang"
git config --global user.email "harryzhang@zju.edu.cn"

# write gopath
cat <<EOT >> /etc/profile
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/root/gocode
EOT

# instal godep
source /etc/profile
go version
apt-get install -y mercurial
go get github.com/tools/godep

# write kpath
cat <<EOT >> /etc/profile
export KPATH=/root/code/kubernetes
export GOPATH=$KPATH/bin:$GOPATH

export PATH=$PATH:$GOPATH/bin
EOT

source /etc/profile

# set up workspace
mkdir -p $KPATH/src/k8s.io/kubernetes
cd $KPATH/src/k8s.io/kubernetes
git clone https://github.com/zju-sel/kubernetes.git .
git remote add upstream 'https://github.com/kubernetes/kubernetes.git'
