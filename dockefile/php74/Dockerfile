FROM php:7.4-fpm-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk update \
    && apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev curl icu-dev libxml2-dev libxslt-dev bzip2-dev gettext-dev openssl rabbitmq-c-dev autoconf  g++ make pkgconfig libssh-dev ffmpeg libwebp-dev yasm  ffmpeg-dev libzip-dev oniguruma-dev \
    && docker-php-ext-configure gd --with-webp=/usr/include/webp --with-jpeg=/usr/include --with-freetype=/usr/include/freetype2/ \
    && docker-php-ext-install gd intl soap xsl xmlrpc bz2 zip pcntl pdo_mysql mysqli mbstring exif bcmath calendar sockets gettext shmop sysvmsg sysvsem sysvshm opcache \
    && :\
    #pecl扩展开始开始
    && pecl channel-update pecl.php.net \
    && set -xe && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install -o -f xdebug-3.0.3 \
    && docker-php-ext-enable xdebug \
    && pecl install -o -f redis-5.3.4 \
    && docker-php-ext-enable redis \
    && apk add libmemcached-dev \
    && pecl install -o -f memcached-3.1.5 \
    && docker-php-ext-enable memcached \
    && pecl install -o -f mongodb-1.9.0 \
    && docker-php-ext-enable mongodb \
    && apk add linux-headers \
    && pecl install -o -f swoole-4.6.4 \
    && docker-php-ext-enable swoole \
    && pecl install -o -f protobuf-3.15.6 \
    && docker-php-ext-enable protobuf \
    && pecl install -o -f amqp-1.10.2 \
    && docker-php-ext-enable amqp \
    #yaf pecl安装有bug,只能用源码安装
    && curl -fsSL 'http://pecl.php.net/get/yaf-3.3.2.tgz' -o yaf.tar.gz  \
    && mkdir -p /tmp/yaf  \
    && tar -xf yaf.tar.gz -C /tmp/yaf --strip-components=1  \
    && docker-php-ext-configure /tmp/yaf --enable-yaf  \
    && docker-php-ext-install /tmp/yaf \
    #tideways 性能分析工具
    && curl -fsSL 'https://github.com/tideways/php-xhprof-extension/archive/refs/tags/v5.0.4.tar.gz' -o tideways.tar.gz  \
    && mkdir -p /tmp/tideways  \
    && tar -xf tideways.tar.gz -C /tmp/tideways --strip-components=1  \
    && docker-php-ext-configure /tmp/tideways  \
    && docker-php-ext-install /tmp/tideways \
    # composer
    && wget -nv -O /usr/local/bin/composer https://github.com/composer/composer/releases/download/2.1.3/composer.phar && chmod u+x /usr/local/bin/composer && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    && wget -nv -O /usr/local/bin/php-cs-fixer  https://cs.symfony.com/download/php-cs-fixer-v2.phar && chmod u+x /usr/local/bin/php-cs-fixer \
    # del
    && docker-php-source delete \
    && rm -rf /tmp/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/pear ~/.pearrc && rm -rf /usr/share/php \
    && apk del  .phpize-deps