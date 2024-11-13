#!/bin/bash

#安装软件
function installSoft(){

#    #安装adb
    sudo apt-get install android-tools-adb
    goInstall
    minicondaInstall
    opencvInstall
}


#go安装
function goInstall(){
      sudo wget -P /tmp https://dl.google.com/go/go1.23.2.linux-amd64.tar.gz
      sudo tar -C /usr/local -xzf /tmp/go1.23.2.linux-amd64.tar.gz
      sudo echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a ~/.bashrc
      source ~/.bashrc
      #执行go的扩展安装
      /usr/local/go/bin/go env -w GO111MODULE=on
      /usr/local/go/bin/go env -w GOPROXY=https://goproxy.cn,direct
      /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest
      sudo ln -s $GOPATH/bin/dlv /usr/local/bin/dlv
}

#opencv安装
function opencvInstall(){
  sudo apt-get install cmake
  sudo apt-get install build-essential libgtk2.0-dev libavcodec-dev libavformat-dev libjpeg.dev libtiff5.dev libswscale-dev
  wget -O ~/opencv-4.10.0.tar.gz https://github.geekery.cn/https://codeload.github.com/opencv/opencv/tar.gz/refs/tags/4.10.0
  tar -xf ~/opencv-4.10.0.tar.gz -C ~
  mkdir ~/opencv
  mkdir ~/opencv-4.10.0/build && cd ~/opencv-4.10.0/build
  cmake .. \
      -DCMAKE_INSTALL_PREFIX="~/opencv" \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=OFF \
      -DWITH_IPP=OFF \
      -DBUILD_IPP_IW=OFF \
      -DWITH_LAPACK=OFF \
      -DWITH_EIGEN=OFF \
      -DCMAKE_INSTALL_LIBDIR=lib64 \
      -DWITH_ZLIB=ON \
      -DBUILD_ZLIB=ON \
      -DWITH_JPEG=ON \
      -DBUILD_JPEG=ON \
      -DWITH_PNG=ON \
      -DBUILD_PNG=ON \
      -DWITH_TIFF=ON \
      -DBUILD_TIFF=ON

  sudo make -j$(nproc)
  sudo make install
}

#pythong的conda环境安装
function minicondaInstall() {
    sudo mkdir -p ~/miniconda3
    sudo wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    sudo bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    sudo rm ~/miniconda3/miniconda.sh
    ~/miniconda3/bin/conda init bash
    #清华源
    ~/miniconda3/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
    ~/miniconda3/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
    ~/miniconda3/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
    ~/miniconda3/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
    ~/miniconda3/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/bioconda/
    ~/miniconda3/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/menpo/
    ~/miniconda3/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/
    #显示检索路径，每次安装包时会将包源路径显示出来
    ~/miniconda3/bin/conda config --set show_channel_urls yes
    ~/miniconda3/bin/conda config --set always_yes True
    #执行以下命令清除索引缓存，保证用的是镜像站提供的索引
    ~/miniconda3/bin/conda clean -i
    # 显示所有镜像通道路径命令
    ~/miniconda3/bin/conda config --show channels
    #不显示base环境
    ~/miniconda3/bin/conda config --set auto_activate_base false
    # 指定环境安装目录
    #~/miniconda3/bin/conda config --add envs_dirs /data/.conda/envs
    #pip3 install   ddddocr   -i   https://pypi.tuna.tsinghua.edu.cn/simple
}

# 默认ssh-key，如果id_rsa.pub和id_rsa文件存在则不生成，否则创建文件id_rsa.pub和id_rsa，并写入秘钥
# 生成key:ssh-keygen -t rsa -C "abner510@126.com"
# 检查key: ssh-keygen -y -f ~/.ssh/id_rsa
function sshKey(){
    if [ -f ~/.ssh/id_rsa.pub ] && [ -f ~/.ssh/id_rsa ];then
        echo "ssh key exist"
    else
        echo "ssh key not exist, create it"
        #这里我直接将公私钥填入文件，不需靠命令生成
        mkdir -p ~/.ssh
        cat <<EOF > ~/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
EOF
        cat <<EOF > ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2m+jr2uAP0Ye6Cg3oCgkIKQqVEbFPundI8MAOHMZVHwqa8OnpScvmfTpaUSFLKmkT846QSrSktn+N+8JBpLFPjQRUwgHVGCslmxVxN2vl0O+OOJ+oDxWtxnqqVWjWd2EcYrlpAnHQotIaQK+GL2OEnPFPrIT9EZ4JPFMVxMraoXrEqiv7O3ctz0vXBV8EE45bMuzeaDbKRA9i0vWrYnTYhwNfGLYReRk6cBGW90wQJBtYGX+qx5al5QQvC0bZU99VX2+ysynoE0tv4MDXn9J9cWa/S2/lX8kSYDoZ9l/8ap4df8VI5v1MVGwV/Y2k1e0FqFDI2skbbXPhkLvTtjU2lFuoIPFv5PStrbyyonw4+M+d3P/6m54zVolIZG6ASxyH/s4GX4IH6ChR0HGl5rdc8GZFsR6KqDVvAWpChxzzLBWA8HBuVvQRM5pBt1sDCpN8TKABKqxnEdOUJQnuuQjAbmu7tQ6FOUwQeArOLaarQZvl4MRkv17byWq4vva7SYE= abner510@126.com
EOF
        chmod 600 ~/.ssh/id_rsa
        chmod 600 ~/.ssh/id_rsa.pub
    fi
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
        echo -e "（1键）换源"
        echo -e "（2键）docker服务安装"
        echo -e "（3键）安装软件"
        echo -e "（q键）退出"
        read -p '选择安装: ' number
        case $number in
          1)
            upSource
            sudo apt-get -y update && sudo apt-get -y upgrade
            ;;
          2)
             echo -e "docker install starting"
             sudo curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
             sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
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
          3)
            echo -e "开发软件安装"
            installSoft
            sshKey
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