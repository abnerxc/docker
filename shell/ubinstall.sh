#!/bin/bash

#无用
#function getVersionNum(){
#    version=`cat /proc/version`
#    cut=${version%%(*}
#    dd=${cut:14}
#}

function dockerAlis() {
    dps="\$(docker ps -aq)"
    dcup="jhm='docker-compose -f /data/docker/jhm.yml up -d --remove-orphans'"
    dcrs="jhm-rs='docker-compose -f /data/docker/jhm.yml restart'"
    dcrm="jhm-rm='docker-compose -f /data/docker/jhm.yml stop  docker-compose -f /data/docker/jhm.yml rm'"
    dcps="jhm-ps='docker-compose -f /data/docker/jhm.yml ps'"
    dcip="docker-ips='docker inspect --format='\"'\"'{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'\"'\"' $dps'"
}

function upSource(){
  sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
  echo "deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -sc) main restricted universe multiverse" | sudo tee /etc/apt/sources.list
  echo "deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -sc) main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
  echo "deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -sc)-updates main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
  echo "deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -sc)-updates main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
  echo "deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -sc)-security main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
  echo "deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -sc)-security main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list
   sudo apt update
}

function main(){
    while [ True ];do
        echo -e "\033[33m ubuntu22.04 docker安装步骤:033[0m"
        echo -e "\033[33m （1键）docker服务安装033[0m"
        echo -e "\033[33m （2键）virtual box挂载安装，请保证安装增加工具和挂载目录已经添加033[0m"
        echo -e "\033[33m （3键）VMware挂载目录033[0m"
        echo -e "\033[33m （4键）安装默认软件033[0m"
        echo -e "\033[33m （q键）退出033[0m"
        read -p '选择安装: ' number
        case $number in
          1)
            echo -e "\033[31m docker install starting033[0m"
             upSource
             sudo apt-get update
             sudo curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
             sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
             sudo apt-get -y update
             sudo apt-get -y install docker-ce
             sudo service docker start
             sudo curl -L https://gh-proxy.com/https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
             sudo chmod -R 777 /usr/local/bin/docker-compose
             sudo gpasswd -a $USER docker
             sudo mkdir -p /etc/docker
             sudo echo '{"registry-mirrors":["https://l714mp7z.mirror.aliyuncs.com"]}' | sudo tee -a /etc/docker/daemon.json
             sudo systemctl daemon-reload  sudo systemctl restart docker  sudo systemctl enable docker
             echo -e "\033[31m docker安装完成，请重启虚拟机挂载增强和目录再执行步骤2或者3033[0m"  exit
            ;;

          2)
            echo -e "\033[31m virtual box增强工具 install starting033[0m"
             sudo mount /dev/cdrom /mnt
             cd /mnt   ./VBoxLinuxAdditions.run
             sudo mkdir -p /data/docker   sudo chmod -R 775 /data/docker
             sudo echo 'mount -t vboxsf docker /data/docker' | sudo tee -a /etc/rc.local  sudo chmod +x /etc/rc.d/rc.local
             dockerAlis
             echo "alias $dcup" | sudo tee -a ~/.bashrc
             echo "alias $dcrs" | sudo tee -a ~/.bashrc
             echo "alias $dcrm" | sudo tee -a ~/.bashrc
             echo "alias $dcps" | sudo tee -a ~/.bashrc
             echo "alias $dcip" | sudo tee -a ~/.bashrc
             source ~/.bashrc
             sudo echo '.host:/ ~ fuse.vmhgfs-fuse allow_other,defaults 0 0' | sudo tee -a /etc/fstab
             sudo apt-get install ufw  sudo ufw disable
             echo -e "\033[31m 请重启电脑033[0m"  exit
            ;;
          3)
            echo -e "\033[31m VMware挂载目录033[0m"
             sudo apt-get -y install open-vm-tools
             sudo mkdir -p /data/docker   sudo chmod -R 777 /data/docker
             dockerAlis
             echo "alias $dcup" | sudo tee -a ~/.bashrc
             echo "alias $dcrs" | sudo tee -a ~/.bashrc
             echo "alias $dcrm" | sudo tee -a ~/.bashrc
             echo "alias $dcps" | sudo tee -a ~/.bashrc
             echo "alias $dcip" | sudo tee -a ~/.bashrc
             source ~/.bashrc
             sudo echo '.host:/ /data/ fuse.vmhgfs-fuse allow_other,defaults 0 0' | sudo tee -a /etc/fstab
             sudo apt-get install ufw  sudo ufw disable
             echo -e "\033[31m 请重启电脑033[0m"  exit
            ;;
          4)
            echo -e "\033[31m 开发软件安装033[0m"
             sudo apt-get -y install open-vm-tools
             sudo mkdir -p /data/docker   sudo chmod -R 777 /data/docker
             dockerAlis
             echo "alias $dcup" | sudo tee -a ~/.bashrc
             echo "alias $dcrs" | sudo tee -a ~/.bashrc
             echo "alias $dcrm" | sudo tee -a ~/.bashrc
             echo "alias $dcps" | sudo tee -a ~/.bashrc
             echo "alias $dcip" | sudo tee -a ~/.bashrc
             source ~/.bashrc
             sudo echo '.host:/ /data/ fuse.vmhgfs-fuse allow_other,defaults 0 0' | sudo tee -a /etc/fstab
             sudo apt-get install ufw  sudo ufw disable
             echo -e "\033[31m 请重启电脑033[0m"  exit
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