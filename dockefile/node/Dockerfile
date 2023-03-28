FROM        node:alpine3.17
LABEL       maintainer="abner510@126.com"
WORKDIR     /home/node
RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --update git openssh && \
            npm config set registry https://registry.npm.taobao.org && yarn config set registry https://registry.npm.taobao.org && npm install -g npm@9.6.2 && \
            npm install -g hexo-cli  && git config --global user.email "abner510@126.com" && git config --global user.name "abner" && \
            npm install -g cnpm --registry=https://registry.npm.taobao.org && \
            npm install webpack -g && npm install -g @vue/cli && npm install -g @vue/cli-init && \
            rm -rf /var/cache/apk/*
EXPOSE      4000
CMD         ["/bin/sh"]