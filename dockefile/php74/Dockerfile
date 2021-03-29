FROM php:7.4-fpm-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
    && apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev curl icu-dev libxml2-dev libxslt-dev bzip2-dev gettext-dev libressl libressl-dev rabbitmq-c-dev autoconf  g++ make pkgconfig libssh-dev ffmpeg libwebp-dev yasm ffmpeg ffmpeg-dev libzip libzip-dev \
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
    #FFmpeg视频处理功能
    && curl -fsSL 'https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2' -o ffmpeg.tar.gz  \
    && mkdir -p /tmp/ffmpeg  \
    && tar -xf ffmpeg.tar.gz -C /tmp/ffmpeg --strip-components=1  \
    && docker-php-ext-configure /tmp/ffmpeg --enable-ffmpeg  \
    && docker-php-ext-install /tmp/ffmpeg \
    #tideways 性能分析工具
    && curl -fsSL 'https://github.com/tideways/php-xhprof-extension/archive/refs/tags/v5.0.4.tar.gz' -o tideways.tar.gz  \
    && mkdir -p /tmp/tideways  \
    && tar -xf tideways.tar.gz -C /tmp/tideways --strip-components=1  \
    && docker-php-ext-configure /tmp/tideways --enable-tideways  \
    && docker-php-ext-install /tmp/tideways \
    #tideways 性能分析工具
    && curl -fsSL 'https://github.com/tideways/php-xhprof-extension/archive/refs/tags/v5.0.4.tar.gz' -o tideways.tar.gz  \
    && mkdir -p /tmp/tideways  \
    && tar -xf tideways.tar.gz -C /tmp/tideways --strip-components=1  \
    && docker-php-ext-configure /tmp/tideways --enable-tideways  \
    && docker-php-ext-install /tmp/tideways \
    #wxwork_finance_sdk PHP 扩展 （会话存档功能需要）
    && ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 \
    && cd /tmp \
    && curl -fsSL "https://github.com/oh-stone/wework-chatdata-sdk/archive/v0.1.0.tar.gz" -o wxwork_finance_sdk.tar.gz \
    && mkdir -p wxwork_finance_sdk \
    && tar -xf wxwork_finance_sdk.tar.gz -C wxwork_finance_sdk --strip-components=1 \
    && cd wxwork_finance_sdk/php7-wxwork-finance-sdk \
    && docker-php-ext-configure /tmp/wxwork_finance_sdk/php7-wxwork-finance-sdk --with-wxwork-finance-sdk=/tmp/wxwork_finance_sdk/C_sdk \
    && docker-php-ext-install /tmp/wxwork_finance_sdk/php7-wxwork-finance-sdk \
    #ffmpeg 扩展

    # composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
    # del
    && docker-php-source delete \
    && rm -rf /tmp/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/pear ~/.pearrc && rm -rf /usr/share/php \
    && apk del  .phpize-deps