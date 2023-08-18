#!/bin/sh
sudo apt-get update && apt-get install cpu-checker openssh-server vim git adb linux-modules-extra-`uname -r` && \
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common && \
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" && \
sudo apt-get -y install docker-ce && \
sudo gpasswd -a ${USER} docker  && sudo mkdir -p /etc/docker && sudo systemctl daemon-reload && sudo systemctl restart docker && sudo systemctl enable docker &&  sudo apt-get upgrade && \
sudo echo '{ "registry-mirrors": ["https://l714mp7z.mirror.aliyuncs.com"] }' >  /etc/docker/daemon.json && \
sudo curl https://ghproxy.com/https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
sudo chmod +x /usr/local/bin/docker-compose && \
sudo echo "binder_linux"  >>  /etc/modules-load.d/redroid.conf  && sudo echo "ashmem_linux"  >>  /etc/modules-load.d/redroid.conf && \
sudo modprobe binder_linux devices="binder,hwbinder,vndbinder" && sudo modprobe ashmem_linux

