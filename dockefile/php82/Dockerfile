FROM php:8.2-fpm-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
    && apk add --no-cache linux-headers g++ make librdkafka-dev libmemcached-dev freetype-dev libjpeg-turbo-dev libpng-dev curl icu-dev libxml2-dev libxslt-dev bzip2-dev gettext-dev openssl autoconf pkgconfig libssh-dev ffmpeg libwebp-dev yasm  ffmpeg-dev libzip-dev oniguruma-dev rabbitmq-c rabbitmq-c-dev  \
    && docker-php-ext-configure gd --with-webp=/usr/include/webp --with-jpeg=/usr/include --with-freetype=/usr/include/freetype2/ \
    && docker-php-ext-install gd intl soap xsl  bz2 zip pcntl pdo_mysql mysqli mbstring exif bcmath calendar sockets gettext shmop sysvmsg sysvsem sysvshm opcache \
    && pecl channel-update pecl.php.net \
    && set -xe && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install -o -f xmlrpc-1.0.0RC3 \
    && docker-php-ext-enable xmlrpc \
    && pecl install -o -f xdebug-3.2.1 \
    && docker-php-ext-enable xdebug \
    && pecl install -o -f redis-5.3.7 \
    && docker-php-ext-enable redis \
    && pecl install -o -f memcached-3.2.0 \
    && docker-php-ext-enable memcached \
    && pecl install -o -f mongodb-1.51.1 \
    && docker-php-ext-enable mongodb \
    && pecl install -o -f swoole-5.0.2 \
    && docker-php-ext-enable swoole \
    && pecl install -o -f protobuf-3.21.1 \
    && docker-php-ext-enable protobuf \
    && pecl install -o -f amqp-1.11.0 \
    && docker-php-ext-enable amqp \
    && pecl install -o -f rdkafka-6.0.3 \
    && docker-php-ext-enable rdkafka \
    && pecl install -o -f SeasClick-0.1.1 \
    && docker-php-ext-enable SeasClick \
    && curl -fsSL 'https://github.com/tideways/php-xhprof-extension/archive/refs/tags/v5.0.4.tar.gz' -o tideways.tar.gz  \
    && mkdir -p /tmp/tideways  \
    && tar -xf tideways.tar.gz -C /tmp/tideways --strip-components=1  \
    && docker-php-ext-configure /tmp/tideways  \
    && docker-php-ext-install /tmp/tideways \
    && wget -nv -O /usr/local/bin/composer https://github.com/composer/composer/releases/download/2.3.7/composer.phar && chmod u+x /usr/local/bin/composer && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && wget -nv -O /usr/local/bin/php-cs-fixer  https://cs.symfony.com/download/php-cs-fixer-v2.phar && chmod u+x /usr/local/bin/php-cs-fixer \
    && wget -nv -O /usr/local/bin/phpunit  http://phar.phpunit.cn/phpunit.phar && chmod u+x /usr/local/bin/phpunit \
    && docker-php-source delete \
    && rm -rf /tmp/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/pear ~/.pearrc && rm -rf /usr/share/php \
    && apk del  .phpize-deps