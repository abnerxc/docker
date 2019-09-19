FROM        centos:latest
LABEL       maintainer="abner510@126.com"
RUN         yum install -y wget  \
            && mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup  \
            && wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo  \
            && yum -y groupinstall 'Development Tools' \
            && yum -y install libX11-devel freetype-devel zlib-devel libxcb-devel libxslt-devel libgcrypt-devel libxml2-devel gnutls-devel libpng-devel libjpeg-turbo-devel libtiff-devel gstreamer-devel dbus-devel fontconfig-devel \
            && echo "download ==========" \
            && curl -fsSL 'http://mirrors.ibiblio.org/wine/source/4.0/wine-4.0.2.tar.xz' -o wine.tar.gz  \
            && mkdir -p /tmp/wine  \
            && tar -xf wine.tar.gz -C /tmp/wine --strip-components=1  \
            && /tmp/wine/configure  --enable-win64  && make && make install \
            && rm wine.tar.gz

VOLUME      /data
