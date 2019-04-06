FROM alpine:edge

ENV MONGO_VERSION=4.0.6-r0

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --no-cache mongodb=${MONGO_VERSION} wget && \
    mkdir -p /data/db && \
    mkdir -p /data/logs && \
    mkdir -p /data/config && \
    addgroup mongodb mongodb && \
    wget --no-check-certificate -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true && \
    rm -rf /var/cache/apk/*

COPY ./docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh && \
    chmod +x usr/local/bin/docker-entrypoint.sh

VOLUME ["/data"]
EXPOSE 27017

CMD ["docker-entrypoint.sh"]