FROM php:5.6-fpm-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
    && apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev curl icu-dev libxml2-dev libxslt-dev bzip2-dev gettext-dev libressl-dev rabbitmq-c-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install intl \
    && docker-php-ext-install soap \
    && docker-php-ext-install xsl \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-install wddx \
    && docker-php-ext-install bz2 \
    && docker-php-ext-install zip \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install exif \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install calendar \
    && docker-php-ext-install sockets \
    && docker-php-ext-install gettext \
    && docker-php-ext-install shmop \
    && docker-php-ext-install sysvmsg \
    && docker-php-ext-install sysvsem \
    && docker-php-ext-install sysvshm \
    && docker-php-ext-install opcache \
    && :\
    #pecl扩展开始开始
    && pecl channel-update pecl.php.net \
    && set -xe && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install -o -f xdebug-2.5.5 \
    && docker-php-ext-enable xdebug \
    && pecl install -o -f redis-3.1.5 \
    && docker-php-ext-enable redis \
    && pecl install memcache-2.2.7 \
    && docker-php-ext-enable memcache \
    && apk add libmemcached-dev \
    && pecl install -o -f memcached-2.2.0 \
    && docker-php-ext-enable memcached \
    && pecl install -o -f mongodb-1.5.0 \
    && docker-php-ext-enable mongodb \
    && pecl install -o -f amqp-1.9.4 \
    && docker-php-ext-enable amqp \
    #yaf pecl安装有bug,只能用源码安装
    && curl -fsSL 'http://pecl.php.net/get/yaf-2.3.5.tgz' -o yaf.tar.gz  \
    && mkdir -p /tmp/yaf  \
    && tar -xf yaf.tar.gz -C /tmp/yaf --strip-components=1  \
    && rm yaf.tar.gz  \
    && docker-php-ext-configure /tmp/yaf --enable-yaf  \
    && docker-php-ext-install /tmp/yaf \
    && apk add linux-headers \
    && pecl install -o -f swoole-1.10.1 \
    && docker-php-ext-enable swoole \
    && pecl install -o -f protobuf-3.3.0 \
    && docker-php-ext-enable protobuf \
    && curl -fsSL 'https://github.com/tideways/php-xhprof-extension/archive/v4.1.5.tar.gz' -o xhprof.tar.gz  \
    && mkdir -p /tmp/xhprof \
    && tar -xf xhprof.tar.gz -C /tmp/xhprof --strip-components=1  \
    && rm xhprof.tar.gz \
    && docker-php-ext-configure /tmp/xhprof --enable-xhprof  \
    && docker-php-ext-install /tmp/xhprof  \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && rm -rf /tmp/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/pear ~/.pearrc && rm -rf /usr/share/php && apk del  .phpize-deps