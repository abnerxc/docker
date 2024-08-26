# 使用Alpine Linux作为基础镜像
#FROM openjdk:8-jdk-alpine
FROM registry.cn-guangzhou.aliyuncs.com/xuchen/proxy:openjdk-8-jdk-alpine

# 设置环境变量
ENV NACOS_VERSION=2.2.0
ENV NACOS_HOME=/nacos
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk

# 创建Nacos目录
RUN mkdir -p $NACOS_HOME

# 下载Nacos服务器
RUN wget -O /tmp/nacos-server.tar.gz https://github.com/alibaba/nacos/releases/download/${NACOS_VERSION}/nacos-server-${NACOS_VERSION}.tar.gz \
    && tar -xzf /tmp/nacos-server.tar.gz -C $NACOS_HOME --strip-components=1 \
    && rm -f /tmp/nacos-server.tar.gz

# 复制启动脚本
COPY startup.sh $NACOS_HOME/bin/

# 暴露Nacos服务端口
EXPOSE 8848

# 设置工作目录
WORKDIR $NACOS_HOME

# 启动Nacos服务
CMD ["bin/startup.sh", "-m", "cluster"]
