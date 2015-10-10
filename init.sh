#!/bin/bash
wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.5.1.linux-amd64.tar.gz

apt-get install git
git config --global user.name "Harry Zhang"
git config --global user.email "harryzhang@zju.edu.cn"

cat <<EOT >> /etc/profile
export PATH=$PATH:/usr/local/go/bin
export GOPATH=/root/gocode
EOT

source /etc/profile
go version
go get github.com/tools/godep

cat <<EOT >> /etc/profile
export KPATH=/root/code/kubernetes
export GOPATH=$KPATH/bin:$GOPATH

export PATH=$PATH:$GOPATH/bin
EOT

source /etc/profile
