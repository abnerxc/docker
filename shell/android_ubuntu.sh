#!/bin/bash

# ssh -i "/Users/abner/Downloads/imac.pem" ubuntu@ec2-13-125-212-122.ap-northeast-2.compute.amazonaws.com

function androidExtractNdk() {
  ARCH="x86_64"
  mkdir ./working && cd ./working && git clone https://gitlab.com/android-generic/android_vendor_google_emu-x86.git && \
  yes | ./android_vendor_google_emu-x86/download-files.sh "${ARCH}" && yes | unzip "${ARCH}-*-linux.zip" && 7z e x86_64/system.img && binwalk -e --depth 1 --count 1 -y 'filesystem' super.img && \
  mkdir extracted && cd extracted && yes | 7z x ../_super.img.extracted/100000.ext && \
  find system \( -name 'libndk_translation*' -o -name '*arm*' -o -name 'ndk_translation*' \) | tar -cf native-bridge.tar -T - && pwd && stat native-bridge.tar && echo "${PWD}/native-bridge.tar"
}

function main(){
  while [ True ];do
    echo -e "\033[33m Redroid-ubuntu install: \033[0m"
    echo -e "\033[33m （1键）服务安装 \033[0m"
    echo -e "\033[33m （2键）x86-native-bridge 安装 \033[0m"
    echo -e "\033[33m （q键）退出 \033[0m"
    read -p '选择安装: ' number
    case $number in
      1)
        echo -e "\033[31m init install start \033[0m" && \
        sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y install  cpu-checker openssh-server vim git adb linux-modules-extra-`uname -r` && \
        sudo apt install linux-headers-`uname -r` linux-image-`uname -r` && \
        sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common sleuthkit p7zip binwalk && \
        curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add - && \
        sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" && \
        sudo apt-get -y install docker-ce && \
        sudo gpasswd -a ${USER} docker  && sudo mkdir -p /etc/docker && sudo systemctl daemon-reload && \
        sudo systemctl restart docker && sudo systemctl enable docker && \
        sudo echo '{ "registry-mirrors": ["https://l714mp7z.mirror.aliyuncs.com"] }' >  /etc/docker/daemon.json && \
        sudo curl https://ghproxy.com/https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
        sudo chmod +x /usr/local/bin/docker-compose && \
        sudo echo "binder_linux"  >>  /etc/modules-load.d/redroid.conf  && sudo echo "ashmem_linux"  >>  /etc/modules-load.d/redroid.conf && \
        sudo echo 'options binder_linux devices="binder,hwbinder,vndbinder"'  >>  /etc/modprobe.d/redroid.conf && \
        sudo modprobe binder_linux devices="binder,hwbinder,vndbinder" && sudo modprobe ashmem_linux && \
        echo -e "\033[31m init end \033[0m" && exit
        ;;
      2)
        echo -e "\033[31m x86 native-bridge starting \033[0m" && \
        sudo mkdir /home/abner/Droid-NDK-Extractor && cd /home/abner/Droid-NDK-Extractor && androidExtractNdk && \
        cd /home/abner/Droid-NDK-Extractor/working/extracted/ && mkdir native-bridge && cd native-bridge && \
        sudo tar -xpf /home/abner/Droid-NDK-Extractor/working/extracted/native-bridge.tar && \
        sudo chmod 0644 system/etc/init/ndk_translation_arm64.rc && sudo chmod 0755 system/bin/arm && \
        sudo chmod 0755 system/bin/arm64 && sudo chmod 0755 system/lib/arm && sudo chmod 0755 system/lib64/arm64 && \
        sudo chmod 0644 system/etc/binfmt_misc/* && sudo tar -cpf native-bridge.tar system && \
        sudo cp native-bridge.tar /home/abner/ && \
        echo -e "\033[31m native-bridge end \033[0m" && exit
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