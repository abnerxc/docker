#!/bin/bash

function getVersionNum(){
    version=`cat /proc/version`
    cut=${version%%(*}
    dd=${cut:14}
}

function main(){
	while [ True ];do
		echo "CentOs7 docker安装步骤:"
		echo "The #1 docker服务安装"
		echo "The #2 windows下virtual box挂载安装，请保证安装增加工具已经添加"
		echo "q键退出"
		read -p '选择安装: ' number
		case $number in
		1)
		echo "docker install starting" \
		&& yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo \
		&& yum install -y yum-utils device-mapper-persistent-data lvm2 docker-ce \
		&& yum makecache fast \
		&& service docker start \
		&& curl -L https://get.daocloud.io/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
		&& chmod +x /usr/local/bin/docker-compose\
		&& gpasswd -a $USER docker \
		&& mkdir -p /etc/docker \
		&& echo '{"registry-mirrors":["https://l714mp7z.mirror.aliyuncs.com"]}'>> /etc/docker/daemon.json \
		&& systemctl daemon-reload \
		&& systemctl restart docker \
		&& systemctl enable docker
		;;

		2)
		echo "virtual box增强工具 install starting" \
		&& yum install -y gcc gcc-devel gcc-c++ gcc-c++-devel make kernel kernel-devel bzip2 vim wget \
		&& getVersionNum && rm -rf /usr/src/linux/$dd && ln -s /usr/src/kernels/$dd /usr/src/linux \
		&& mount /dev/cdrom /mnt \
		&& cd /mnt &&  ./VBoxLinuxAdditions.run \
		&& sudo mkdir /root/docker  && chmod -R 777 /root/docker && sudo mount -t vboxsf docker /root/docker \
		&& echo 'docker /root/server   vboxsf rw,gid=100,uid=1000,auto 0 0'>> /etc/fstab \
		&& echo "请服务器重启"
		;;

		"q"|"quit")
      exit
    ;;

    *)
      echo "Input error!!"
    ;;

		esac
	done
}

main
