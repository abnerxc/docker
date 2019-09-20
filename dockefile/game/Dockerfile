FROM        ubuntu:latest
LABEL       maintainer="abner510@126.com"
RUN         sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list  \
            && apt-get clean && apt-get update \
            && apt-get -y install sudo git \
            && cd /tmp && git clone --depth 1 https://gitee.com/wszqkzqk/deepin-wine-for-ubuntu.git   \
            && /tmp/deepin-wine-for-ubuntu/install.sh    \

VOLUME      /data
