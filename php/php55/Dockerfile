FROM registry.cn-hangzhou.aliyuncs.com/xuchen/nphp:5.5

COPY ./sources.list.jessie /etc/apt/sources.list

RUN apt-get clean && apt-get update

RUN pecl channel-update pecl.php.net \
#    && pecl install xdebug-2.2.7 \
#    && docker-php-ext-enable xdebug \
#    && pecl install redis-3.1.5 \
#    && docker-php-ext-enable redis \
#-err-    && pecl install memcache-2.2.1 \
#-err-    && docker-php-ext-enable memcache \
#    && apt-get install -y libmemcached-dev zlib1g-dev  \
#    && pecl install memcached-2.2.0 \
#    && docker-php-ext-enable memcached \
#    && apt-get install -y openssl libssl-dev  \
#    && pecl install mongo-1.6.16 \
#    && docker-php-ext-enable mongo \
#    && apt-get install -y openssl libssl-dev  \
#    && pecl install mongodb-1.3.0 \
#    && docker-php-ext-enable mongodb \
    && pecl install yaf-2.2.5 \
    && docker-php-ext-enable yaf \
    && apt-get install -y git \
    && cd /tmp && git clone --depth 1 git://github.com/phalcon/cphalcon.git \
    && cd cphalcon/build &&  ./install \
    && docker-php-ext-enable phalcon \
    && pecl install swoole-1.10.1 \
    && docker-php-ext-enable swoole \
    && pecl install protobuf-3.3.0 \
    && docker-php-ext-enable protobuf \
    && pecl install xhprof-0.9.4 \
    && docker-php-ext-enable xhprof \
    && rm -rf /tmp/*