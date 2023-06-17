FROM        node:16.20.0-alpine
RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --update git openssh
WORKDIR     /app
RUN         npm config set registry https://registry.npm.taobao.org && yarn config set registry https://registry.npm.taobao.org && \
            npm install -g hexo-cli  && git config --global user.email abner510@126.com && git config --global user.name abner && \
            npm install webpack -g && npm install -g @vue/cli && \
            rm -rf /var/cache/apk/*
EXPOSE      3000