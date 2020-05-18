FROM        alpine:latest
LABEL       maintainer="abner510@126.com"
RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
            apk add --update bash git nodejs nodejs-npm && \
            npm install hexo-cli -g && npm config set registry https://registry.npm.taobao.org && \
            git config --global user.email "abner510@126.com" && git config --global user.name "abner" && \
            rm -rf /var/cache/apk/*
VOLUME      /app
EXPOSE      3000
CMD         /bin/bash