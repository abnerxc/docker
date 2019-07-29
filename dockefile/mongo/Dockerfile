FROM    alpine:latest
LABEL   maintainer="abner510@126.com"
RUN     sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
        && apk add --no-cache mongodb

VOLUME  /data/db
EXPOSE  27017

COPY run.sh /root
ENTRYPOINT [ "/root/run.sh" ]
CMD [ "mongod", "--bind_ip", "0.0.0.0" ]
