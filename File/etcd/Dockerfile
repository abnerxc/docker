FROM        alpine:latest
RUN         sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
            apk add --update ca-certificates openssl tar && \
            wget https://github.com/coreos/etcd/releases/download/v3.3.12/etcd-v3.3.12-linux-amd64.tar.gz && \
            tar xzvf etcd-v3.3.12-linux-amd64.tar.gz && \
            mv etcd-v3.3.12-linux-amd64/etcd* /bin/ && \
            apk del --purge tar openssl && \
            rm -Rf etcd-v3.3.12-linux-amd64* /var/cache/apk/*
VOLUME      /data
EXPOSE      2379 2380
CMD         ["/bin/etcd"]