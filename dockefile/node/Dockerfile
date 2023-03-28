FROM        alpine:3.12
LABEL       maintainer="abner510@126.com"
RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --update bash git openssh nodejs nodejs-npm && \
            npm install -g hexo-cli  && npm install -g yarn && git config --global user.email "abner510@126.com" && git config --global user.name "abner" && \
            yarn config set registry https://registry.npm.taobao.org && \
            npm config set registry https://registry.npm.taobao.org && npm install -g cnpm --registry=https://registry.npm.taobao.org && npm install webpack -g && npm install -g @vue/cli && npm install -g @vue/cli-init && \
            rm -rf /var/cache/apk/*
RUN         mkdir /app
WORKDIR     /app
RUN         chmod +x /app
VOLUME      /app
EXPOSE      4000
CMD         /bin/bash