FROM        alpine:latest
LABEL       maintainer="abner510@126.com"
RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
            apk add --update mongodb mongodb-tools && \
            mkdir -p /data/db && \
            chown -R mongodb /data/db && \
            rm -Rf /var/cache/apk/*
VOLUME      /data
EXPOSE      27017
CMD         ["mongod"]