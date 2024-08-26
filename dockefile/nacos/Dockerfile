# 使用Alpine Linux作为基础镜像
FROM openjdk:8-jdk-alpine

# 设置环境变量
ENV NACOS_VERSION=1.4.1
ENV NACOS_HOME=/nacos
ENV FUNCTION_MODE=cluster
ENV JVM_XMS=512m
ENV JVM_XMX=512m
ENV JVM_XMN=256m

# 下载Nacos
RUN wget -O /tmp/nacos-server-${NACOS_VERSION}.tar.gz https://github.com/alibaba/nacos/releases/download/${NACOS_VERSION}/nacos-server-${NACOS_VERSION}.tar.gz \
    && mkdir -p ${NACOS_HOME} \
    && tar -xzf /tmp/nacos-server-${NACOS_VERSION}.tar.gz -C${NACOS_HOME} --strip-components=1 \
    && rm -f /tmp/nacos-server-${NACOS_VERSION}.tar.gz

# 修改默认启动脚本，使其适应Docker环境
RUN sed -i 's|-Djava.ext.dirs=/usr/lib/jvm/java-8-openjdk/jre/lib/ext:/usr/lib/jvm/java-8-openjdk/jre/lib/ext:\$JAVA_EXT_DIRS|-Djava.ext.dirs=/usr/lib/jvm/java-8-openjdk/jre/lib/ext:/usr/lib/jvm/java-8-openjdk/jre/lib/rt.jar:/usr/lib/jvm/java-8-openjdk/jre/classes/\$JAVA_EXT_DIRS|g' ${NACOS_HOME}/bin/startup.sh

# 暴露Nacos端口
EXPOSE 8848

# 启动Nacos
CMD ["/bin/sh", "-c", "${NACOS_HOME}/bin/startup.sh -m${FUNCTION_MODE} -p ${JVM_XMS} -P${JVM_XMX}"]

# 删除默认的cluster.conf文件，因为我们将使用外部挂载来配置
RUN rm ${NACOS_HOME}/conf/cluster.conf
