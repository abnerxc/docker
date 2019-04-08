FROM php:7.0-fpm-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
    && apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev curl icu-dev libxml2-dev libxslt-dev bzip2-dev gettext-dev libressl libressl-dev rabbitmq-c-dev autoconf  g++ make pkgconfig libssh-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install  gd intl soap xsl xmlrpc wddx bz2 zip pcntl pdo_mysql mysqli mbstring exif bcmath calendar sockets gettext shmop sysvmsg sysvsem sysvshm opcache \
    && :\
    #pecl扩展开始开始
    && pecl channel-update pecl.php.net \
    && set -xe && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install -o -f xdebug-2.6.0 \
    && docker-php-ext-enable xdebug \
    && pecl install -o -f redis-3.1.5 \
    && docker-php-ext-enable redis \
    && apk add libmemcached-dev \
    && pecl install -o -f memcached-3.0.4 \
    && docker-php-ext-enable memcached \
    && pecl install -o -f mongodb-1.4.2 \
    && docker-php-ext-enable mongodb \
    && apk add linux-headers \
    && pecl install -o -f swoole-2.1.0 \
    && docker-php-ext-enable swoole \
    && pecl install -o -f protobuf-3.5.1 \
    && docker-php-ext-enable protobuf \
    && pecl install -o -f amqp-1.9.4 \
    && docker-php-ext-enable amqp \
    #yaf pecl安装有bug,只能用源码安装
    && curl -fsSL 'http://pecl.php.net/get/yaf-3.0.6.tgz' -o yaf.tar.gz  \
    && mkdir -p /tmp/yaf  \
    && tar -xf yaf.tar.gz -C /tmp/yaf --strip-components=1  \
    && rm yaf.tar.gz  \
    && docker-php-ext-configure /tmp/yaf --enable-yaf  \
    && docker-php-ext-install /tmp/yaf \
    # xhprof
    && curl -fsSL 'https://github.com/tideways/php-xhprof-extension/archive/v4.1.5.tar.gz' -o xhprof.tar.gz  \
    && mkdir -p /tmp/xhprof \
    && tar -xf xhprof.tar.gz -C /tmp/xhprof --strip-components=1  \
    && rm xhprof.tar.gz \
    && docker-php-ext-configure /tmp/xhprof --enable-xhprof  \
    && docker-php-ext-install /tmp/xhprof  \
    # composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    # del
    && rm -rf /tmp/* && rm -rf /var/lib/apt/lists/* && rm -rf /usr/share/php \
    && apk del  .phpize-deps