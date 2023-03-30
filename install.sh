#!/bin/bash

function getVersionNum(){
    version=`cat /proc/version`
    cut=${version%%(*}
    dd=${cut:14}
}

function dockerAlis() {
    dps="\$(docker ps -aq)"
    dcup="jhm='docker-compose -f /root/docker/jhm.yml up -d'"
    dcrs="jhm-rs='docker-compose -f /root/docker/jhm.yml restart'"
    dcrm="jhm-rm='docker-compose -f /root/docker/jhm.yml stop && docker-compose -f /root/docker/jhm.yml rm'"
    dcps="jhm-ps='docker-compose -f /root/docker/jhm.yml ps'"
    dcip="docker-ips='docker inspect --format='\"'\"'{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'\"'\"' $dps'"
}

function yumSource(){
    mv /etc/yum.repos.d/centos.repo /etc/yum.repos.d/centos.repo.backup \
    && cat > /etc/yum.repos.d/centos.repo <<- EOF
[AppStream]
name=CentOS-\$releasever - AppStream - mirrors.ustc.edu.cn
baseurl=https://mirrors.ustc.edu.cn/centos-stream/\$stream/AppStream/\$basearch/os/
gpgcheck=1
gpgkey=https://mirrors.ustc.edu.cn/centos-stream/RPM-GPG-KEY-CentOS-Official

[BaseOS]
name=CentOS-\$releasever - BaseOS - mirrors.ustc.edu.cn
baseurl=https://mirrors.ustc.edu.cn/centos-stream/\$stream/BaseOS/\$basearch/os/
gpgcheck=1
gpgkey=https://mirrors.ustc.edu.cn/centos-stream/RPM-GPG-KEY-CentOS-Official

[CRB]
name=CentOS-\$releasever - CRB - mirrors.ustc.edu.cn
baseurl=https://mirrors.ustc.edu.cn/centos-stream/\$stream/CRB/\$basearch/os/
gpgcheck=1
gpgkey=https://mirrors.ustc.edu.cn/centos-stream/RPM-GPG-KEY-CentOS-Official

[HighAvailability]
name=CentOS-\$releasever - HighAvailability - mirrors.ustc.edu.cn
baseurl=https://mirrors.ustc.edu.cn/centos-stream/\$stream/HighAvailability/\$basearch/os/
gpgcheck=1
gpgkey=https://mirrors.ustc.edu.cn/centos-stream/RPM-GPG-KEY-CentOS-Official

[NFV]
name=CentOS-\$releasever - NFV - mirrors.ustc.edu.cn
baseurl=https://mirrors.ustc.edu.cn/centos-stream/\$stream/NFV/\$basearch/os/
gpgcheck=1
gpgkey=https://mirrors.ustc.edu.cn/centos-stream/RPM-GPG-KEY-CentOS-Official

[RT]
name=CentOS-\$releasever - RT - mirrors.ustc.edu.cn
baseurl=https://mirrors.ustc.edu.cn/centos-stream/\$stream/RT/\$basearch/os/
gpgcheck=1
gpgkey=https://mirrors.ustc.edu.cn/centos-stream/RPM-GPG-KEY-CentOS-Official

[ResilientStorage]
name=CentOS-\$releasever - ResilientStorage - mirrors.ustc.edu.cn
baseurl=https://mirrors.ustc.edu.cn/centos-stream/\$stream/ResilientStorage/\$basearch/os/
gpgcheck=1
gpgkey=https://mirrors.ustc.edu.cn/centos-stream/RPM-GPG-KEY-CentOS-Official
EOF
yum install -y epel-release
}

function main(){
    while [ True ];do
        echo -e "\033[33m Centos-steam9 docker安装步骤: \033[0m"
        echo -e "\033[33m The #1 docker服务安装 \033[0m"
        echo -e "\033[33m The #2 virtual box挂载安装，请保证安装增加工具和挂载目录已经添加 \033[0m"
        echo -e "\033[33m q键退出 \033[0m"
        read -p '选择安装: ' number
        case $number in
          1)
            echo -e "\033[31m docker install starting \033[0m" \
            && curl -o /etc/yum.repos.d/docker-ce.repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo \
            && yum clean all -y &&  yum update -y && yum install -y epel-release && yum makecache -y \
            && yum -y install gcc gcc-c++ make kernel-devel-`uname -r` kernel-headers-`uname -r` bzip2 dkms elfutils-libelf-devel  \
            && yum -y install docker-ce --allowerasing \
            && service docker start \
            && curl -L https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
            && chmod -R 777 /usr/local/bin/docker-compose \
            && gpasswd -a $USER docker \
            && mkdir -p /etc/docker \
            && echo '{"registry-mirrors":["https://l714mp7z.mirror.aliyuncs.com"]}'>> /etc/docker/daemon.json \
            && systemctl daemon-reload && systemctl restart docker && systemctl enable docker \
            && echo -e "\033[31m docker安装完成，请重启虚拟机挂载增强和目录再执行步骤2 \033[0m" && exit
            ;;

          2)
            echo -e "\033[31m virtual box增强工具 install starting \033[0m" \
            && mount /dev/cdrom /mnt \
            && cd /mnt &&  ./VBoxLinuxAdditions.run \
            && mkdir -p /root/docker  && chmod -R 775 /root/docker \
            && echo 'docker /root/docker   vboxsf rw,gid=100,uid=1000,auto 0 0'>> /etc/fstab \
            && dockerAlis \
            && echo "alias $dcup">> /root/.bashrc \
            && echo "alias $dcrs">> /root/.bashrc \
            && echo "alias $dcrm">> /root/.bashrc \
            && echo "alias $dcps">> /root/.bashrc \
            && echo "alias $dcip">> /root/.bashrc \
            && source /root/.bashrc \
            && firewall-cmd --zone=public --add-port=80/tcp --add-port=3306/tcp --add-port=6379/tcp --permanent \
            && firewall-cmd --reload \
            && echo -e "\033[31m 请重启电脑 \033[0m" && exit
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
