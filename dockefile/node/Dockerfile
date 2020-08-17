FROM        alpine:latest
LABEL       maintainer="abner510@126.com"
RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
            apk add --update bash git openssh nodejs nodejs-npm && \
            npm install hexo-cli -g && npm install -g @vue/cli && \
            git config --global user.email "abner510@126.com" && git config --global user.name "abner" && \
            rm -rf /var/cache/apk/*
VOLUME      /app
EXPOSE      4000
CMD         /bin/bash