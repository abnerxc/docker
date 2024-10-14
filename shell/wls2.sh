#!/bin/bash

#安装软件
function installSoft(){
    #go的安装
    sudo wget https://dl.google.com/go/go1.23.2.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz
    sudo echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a ~/.bashrc
    source ~/.bashrc
    #执行go的扩展安装
    go env -w GO111MODULE=on
    go env -w GOPROXY=https://goproxy.cn,direct
    go install github.com/go-delve/delve/cmd/dlv@latest
    sudo ln -s $GOPATH/bin/dlv /usr/local/bin/dlv
    #安装adb
    sudo apt-get install android-tools-adb
}

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
        echo -e "ubuntu22.04 docker安装步骤:"
        echo -e "（1键）docker服务安装"
        echo -e "（2键）VMware挂载目录"
        echo -e "（4键）安装默认软件"
        echo -e "（q键）退出"
        read -p '选择安装: ' number
        case $number in
          1)
            echo -e "docker install starting"
             upSource
             sudo apt-get update
             sudo curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
             sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
             sudo apt-get -y update
             sudo apt-get -y install docker-ce vim
             sudo service docker start
             sudo curl -L https://gh-proxy.com/https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
             sudo chmod -R 777 /usr/local/bin/docker-compose
             sudo gpasswd -a $USER docker
             sudo mkdir -p /etc/docker
             sudo echo '{"registry-mirrors":["https://l714mp7z.mirror.aliyuncs.com"]}' | sudo tee -a /etc/docker/daemon.json
             sudo systemctl daemon-reload  sudo systemctl restart docker  sudo systemctl enable docker
             echo -e "docker安装完成，请重启虚拟机挂载增强和目录再执行步骤2或者3"  exit
            ;;
          2)
            echo -e "\033[31m 其他安装"
             dockerAlis
             echo "alias $dcup" | sudo tee -a ~/.bashrc
             echo "alias $dcrs" | sudo tee -a ~/.bashrc
             echo "alias $dcrm" | sudo tee -a ~/.bashrc
             echo "alias $dcps" | sudo tee -a ~/.bashrc
             echo "alias $dcip" | sudo tee -a ~/.bashrc
             source ~/.bashrc
             sudo apt-get install ufw  sudo ufw disable
             echo -e "请重启电脑"  exit
            ;;
          3)
            echo -e "开发软件安装"
            installSoft
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