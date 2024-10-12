#!/bin/bash

#无用
#function getVersionNum(){
#    version=`cat /proc/version`
#    cut=${version%%(*}
#    dd=${cut:14}
#}

function dockerAlis() {
    dps="\$(docker ps -aq)"
    dcup="jhm='docker-compose -f /root/docker/jhm.yml up -d --remove-orphans'"
    dcrs="jhm-rs='docker-compose -f /root/docker/jhm.yml restart'"
    dcrm="jhm-rm='docker-compose -f /root/docker/jhm.yml stop && docker-compose -f /root/docker/jhm.yml rm'"
    dcps="jhm-ps='docker-compose -f /root/docker/jhm.yml ps'"
    dcip="docker-ips='docker inspect --format='\"'\"'{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'\"'\"' $dps'"
}

#function upSource(){
#    rm -rf /etc/yum.repos.d/backup &&  mkdir /etc/yum.repos.d/backup \
#    && cp /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup/ \
#    && sed -i 's|metalink|#metalink|g' /etc/yum.repos.d/*.repo \
#    && sed -i '/name=CentOS Stream $releasever - BaseOS/a baseurl=https://mirrors.ustc.edu.cn/centos-stream/$stream/BaseOS/$basearch/os/' /etc/yum.repos.d/*.repo \
#    && sed -i '/name=CentOS Stream $releasever - AppStream/a baseurl=https://mirrors.ustc.edu.cn/centos-stream/$stream/AppStream/$basearch/os/' /etc/yum.repos.d/*.repo \
#    && sed -i '/name=CentOS Stream $releasever - Extras packages/a baseurl=https://mirrors.ustc.edu.cn/centos-stream/SIGs/$stream/extras/$basearch/extras-common/' /etc/yum.repos.d/*.repo
#}

function upSource(){
    # 创建备份目录
    if [ ! -d "/etc/yum.repos.d/backup" ]; then
        mkdir -p /etc/yum.repos.d/backup
    fi
    # 备份原始的.repo文件
    cp /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup/
    # 交大源
    sed -e 's|^mirrorlist=|#mirrorlist=|g' \
        -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.sjtug.sjtu.edu.cn/rocky|g' \
        -i.bak \
        /etc/yum.repos.d/[Rr]ocky*.repo
    # 清理缓存并生成新的缓存
    dnf clean all
    dnf makecache
}

function main(){
    while [ True ];do
        echo -e "\033[33m Centos-steam9 docker安装步骤: \033[0m"
        echo -e "\033[33m （1键）docker服务安装 \033[0m"
        echo -e "\033[33m （2键）virtual box挂载安装，请保证安装增加工具和挂载目录已经添加 \033[0m"
        echo -e "\033[33m （3键）VMware挂载目录 \033[0m"
        echo -e "\033[33m （q键）退出 \033[0m"
        read -p '选择安装: ' number
        case $number in
          1)
            echo -e "\033[31m docker install starting \033[0m" \
            && upSource \
            && dnf install yum-utils && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo \
            && sed -i 's+https://download.docker.com+https://mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo \
            && dnf clean all -y &&  dnf update -y && dnf makecache -y  \
            && dnf -y install gcc gcc-c++ make bzip2  docker-ce \
            && service docker start \
            && curl -L https://gh-proxy.com/https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose \
            && chmod -R 777 /usr/local/bin/docker-compose \
            && gpasswd -a $USER docker \
            && mkdir -p /etc/docker \
            && echo '{"registry-mirrors":["https://l714mp7z.mirror.aliyuncs.com"]}'>> /etc/docker/daemon.json \
            && systemctl daemon-reload && systemctl restart docker && systemctl enable docker \
            && echo -e "\033[31m docker安装完成，请重启虚拟机挂载增强和目录再执行步骤2或者3 \033[0m" && exit
            ;;

          2)
            echo -e "\033[31m virtual box增强工具 install starting \033[0m" \
            && mount /dev/cdrom /mnt \
            && cd /mnt &&  ./VBoxLinuxAdditions.run \
            && mkdir -p /root/docker  && chmod -R 775 /root/docker \
            && echo 'mount -t vboxsf docker /root/docker'>> /etc/rc.local && chmod +x /etc/rc.d/rc.local \
            && dockerAlis \
            && echo "alias $dcup" | sudo tee -a ~/.bashrc \
            && echo "alias $dcrs" | sudo tee -a ~/.bashrc \
            && echo "alias $dcrm" | sudo tee -a ~/.bashrc \
            && echo "alias $dcps" | sudo tee -a ~/.bashrc \
            && echo "alias $dcip" | sudo tee -a ~/.bashrc \
            && source /root/.bashrc \
            && systemctl disable firewalld \
            && echo -e "\033[31m 请重启电脑 \033[0m" && exit
            ;;
          3)
            echo -e "\033[31m VMware挂载目录 \033[0m" \
            && dnf -y install open-vm-tools \
            && mkdir -p /root/docker  && chmod -R 775 /root/docker \
            && dockerAlis \
            && echo "alias $dcup" | sudo tee -a ~/.bashrc \
            && echo "alias $dcrs" | sudo tee -a ~/.bashrc \
            && echo "alias $dcrm" | sudo tee -a ~/.bashrc \
            && echo "alias $dcps" | sudo tee -a ~/.bashrc \
            && echo "alias $dcip" | sudo tee -a ~/.bashrc \
            && echo "alias dcgz='vmhgfs-fuse .host:/docker /root/docker -o allow_other'">> /root/.bashrc \
            && source /root/.bashrc \
            && systemctl disable firewalld \
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