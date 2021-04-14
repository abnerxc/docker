FROM        alpine:latest
LABEL       maintainer="abner510@126.com"
RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --update bash git openssh nodejs nodejs-npm && \
            npm install -g hexo-cli  && git config --global user.email "abner510@126.com" && git config --global user.name "abner" && \
            npm config set registry https://registry.npm.taobao.org && npm install -g cnpm --registry=https://registry.npm.taobao.org && npm install webpack -g && npm install -g @vue/cli && npm install -g @vue/cli-init && \
            #安装指定版本node,不然hexo报错
            npm install -g n && n v12.18.1 && \
            rm -rf /var/cache/apk/*
RUN         mkdir /app
WORKDIR     /app
RUN         chmod +x /app
VOLUME      /app
EXPOSE      4000
CMD         /bin/bash