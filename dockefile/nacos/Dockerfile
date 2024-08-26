# Use Alpine Linux as the base image
FROM openjdk:8-jdk-alpine

# Set Nacos version as an environment variable
ENV NACOS_VERSION=2.2.0

# Install required dependencies
RUN apk add --no-cache bash curl tar

# Download and extract Nacos
RUN mkdir -p /opt/nacos \
    && curl -L https://github.com/alibaba/nacos/releases/download/${NACOS_VERSION}/nacos-server-${NACOS_VERSION}.tar.gz | tar -zx -C /opt/nacos --strip-components=1

# Create the necessary directories for external configuration
RUN mkdir -p /opt/nacos/conf/custom

# Expose ports
EXPOSE 8848 9848 9849

# Define mount points
VOLUME /opt/nacos/conf/custom

# Set working directory
WORKDIR /opt/nacos

# Start Nacos server in cluster mode
CMD ["sh", "-c", "/opt/nacos/bin/startup.sh --spring.config.additional-location=file:/opt/nacos/conf/custom/application.properties --cluster.conf=file:/opt/nacos/conf/custom/cluster.conf"]
