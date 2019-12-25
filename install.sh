#!/bin/bash

function getVersionNum(){
    version=`cat /proc/version`
    cut=${version%%(*}
    dd=${cut:14}
}

function dockerAlis() {
    dps="\$(docker ps -aq)"
    dcup="ztth='docker-compose -f /root/docker/ztth.yml up -d'"
    dcrs="ztth-rs='docker-compose -f /root/docker/ztth.yml restart'"
    dcrm="ztth-rm='docker-compose -f /root/docker/ztth.yml stop && docker-compose -f /root/docker/ztth.yml rm'"
    dcps="ztth-ps='docker-compose -f /root/docker/ztth.yml ps'"
    dcip="docker-ips='docker inspect --format='\"'\"'{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'\"'\"' $dps'"
}

function main(){
	while [ True ];do
		echo -e "\033[33m CentOs7 docker安装步骤: \033[0m"
		echo -e "\033[33m The #1 docker服务安装 \033[0m"
		echo -e "\033[33m The #2 virtual box挂载安装，请保证安装增加工具和挂载目录已经添加 \033[0m"
		echo -e "\033[33m q键退出 \033[0m"
		read -p '选择安装: ' number
		case $number in
          1)
            echo -e "\033[31m docker install starting \033[0m" \
            && yum install -y wget \
            && mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
            && wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
            && yum install -y yum-utils \
            && yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo \
            && yum install -y gcc gcc-devel gcc-c++ gcc-c++-devel make kernel kernel-devel bzip2 vim wget device-mapper-persistent-data lvm2 docker-ce \
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
            && echo -e "\033[31m docker安装完成，请重启电脑，执行步骤2 \033[0m" && exit
            ;;

          2)
            echo -e "\033[31m virtual box增强工具 install starting \033[0m" \
            && getVersionNum && rm -rf /usr/src/linux && ln -s /usr/src/kernels/$dd /usr/src/linux \
            && mount /dev/cdrom /mnt \
            && cd /mnt &&  ./VBoxLinuxAdditions.run \
            && mkdir -p /root/docker  && chmod -R 777 /root/docker \
            && echo 'docker /root/docker   vboxsf rw,gid=100,uid=1000,auto 0 0'>> /etc/fstab \
            && dockerAlis \
            && echo "alias $dcup">> /root/.bashrc \
            && echo "alias $dcrs">> /root/.bashrc \
            && echo "alias $dcrm">> /root/.bashrc \
            && echo "alias $dcps">> /root/.bashrc \
            && echo "alias $dcip">> /root/.bashrc \
            && source /root/.bashrc \
            && echo -e "\033[31m 请服务器重启 \033[0m"] && exit
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
