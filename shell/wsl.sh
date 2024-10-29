#!/bin/bash




#安装软件
function installSoft(){
    #go的安装
    sudo wget -P /tmp https://dl.google.com/go/go1.23.2.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf /tmp/go1.23.2.linux-amd64.tar.gz
    sudo echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a ~/.bashrc
    source ~/.bashrc
    #执行go的扩展安装
    /usr/local/go/bin/go env -w GO111MODULE=on
    /usr/local/go/bin/go env -w GOPROXY=https://goproxy.cn,direct
    /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest
    sudo ln -s $GOPATH/bin/dlv /usr/local/bin/dlv
    #python Miniconda
    sudo mkdir -p ~/miniconda3
    sudo wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    sudo bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    sudo rm ~/miniconda3/miniconda.sh
    pip3 install   ddddocr   -i   https://pypi.tuna.tsinghua.edu.cn/simple
    #安装adb
    sudo apt-get install android-tools-adb
    #git ssh
    #ssh-keygen -t rsa -C "abner510@126.com"
}

function dockerAlis() {
    dps="\$(docker ps -aq)"
    dcup="jhm='docker-compose -f /mnt/f/work/docker/jhm.yml up -d --remove-orphans'"
    dcrs="jhm-rs='docker-compose -f /mnt/f/work/docker/jhm.yml restart'"
    dcrm="jhm-rm='docker-compose -f /mnt/f/work/docker/jhm.yml stop  && docker-compose -f /mnt/f/work/docker/jhm.yml rm'"
    dcps="jhm-ps='docker-compose -f /mnt/f/work/docker/jhm.yml ps'"
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
  sudo apt upgrade
}

function main(){
    while [ True ];do
        echo -e "ubuntu22.04 docker安装步骤:"
        echo -e "（1键）docker服务安装"
        echo -e "（2键）安装软件"
        echo -e "（q键）退出"
        read -p '选择安装: ' number
        case $number in
          1)
            echo -e "docker install starting"
             sudo curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
             sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
             upSource
             sudo apt-get -y update
             sudo apt-get -y install docker-ce vim git
             sudo service docker start
             sudo curl -L https://gh-proxy.com/https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
             sudo chmod -R 777 /usr/local/bin/docker-compose
             sudo gpasswd -a $USER docker
             sudo mkdir -p /etc/docker
             sudo echo '{"registry-mirrors":["https://l714mp7z.mirror.aliyuncs.com"]}' | sudo tee -a /etc/docker/daemon.json
             sudo systemctl daemon-reload  sudo systemctl restart docker  sudo systemctl enable docker
             dockerAlis
             echo "alias $dcup" | sudo tee -a ~/.bashrc
             echo "alias $dcrs" | sudo tee -a ~/.bashrc
             echo "alias $dcrm" | sudo tee -a ~/.bashrc
             echo "alias $dcps" | sudo tee -a ~/.bashrc
             echo "alias $dcip" | sudo tee -a ~/.bashrc
             source ~/.bashrc
            ;;
          2)
            echo -e "开发软件安装"
            installSoft
            echo -e "重启命令行"  exit
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