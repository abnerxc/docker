#!/bin/bash

function getVersionNum(){
    version=`cat /proc/version`
    cut=${version%%(*}
    dd=${cut:14}
}

function main(){
	while [ True ];do
		echo -e "\033[32m CentOs7 docker安装步骤: \033[0m"
		echo -e "\033[32m The #1 docker服务安装 \033[0m"
		echo -e "\033[32m The #2 windows下virtual box挂载安装，请保证安装增加工具已经添加 \033[0m"
		echo -e "\033[32m The #3 添加开机启动和自动挂载 \033[0m"
		echo -e "\033[32m q键退出 \033[0m"
		read -p '选择安装: ' number
		case $number in
		1)
		echo -e "\033[31m docker install starting \033[0m" \
		&& yum install -y yum-utils \
		&& yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo \
		&& yum install -y device-mapper-persistent-data lvm2 docker-ce \
		&& yum makecache fast \
		&& service docker start \
		&& curl -L https://get.daocloud.io/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
		&& chmod +x /usr/local/bin/docker-compose\
		&& gpasswd -a $USER docker \
		&& mkdir -p /etc/docker \
		&& echo '{"registry-mirrors":["https://l714mp7z.mirror.aliyuncs.com"]}'>> /etc/docker/daemon.json \
		&& systemctl daemon-reload \
		&& systemctl restart docker \
		&& systemctl enable docker \
		&& echo -e "\033[31m docker安装完成 \033[0m"
		;;

		2)
		echo "\033[31m virtual box增强工具 install starting \033[0m" \
		&& yum install -y gcc gcc-devel gcc-c++ gcc-c++-devel make kernel kernel-devel bzip2 vim wget \
		&& getVersionNum && rm -rf /usr/src/linux/$dd/ && ln -s /usr/src/kernels/$dd /usr/src/linux \
		&& mount /dev/cdrom /mnt \
		&& cd /mnt &&  ./VBoxLinuxAdditions.run \
		&& echo -e "\033[31m 请服务器重启 \033[0m"
		;;

		3)
		echo "\033[31m 自动挂载开始执行 \033[0m" \
		&& mkdir -p /root/docker  && chmod -R 777 /root/docker && modprobe vboxsf &&mount -t vboxsf docker /root/docker \
		&& echo 'docker /root/docker   vboxsf rw,gid=100,uid=1000,auto 0 0'>> /etc/fstab \
		&& echo -e "\033[31m 请服务器重启 \033[0m"
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
