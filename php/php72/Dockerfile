FROM php:7.2-fpm

#COPY ./sources.list.stretch /etc/apt/sources.list

# Extensions: ctype, dom, fileinfo, ftp, hash, iconv, json, pdo, pdo_sqlite, session,
# tokenizer, simplexml, xml, xmlreader, xmlwriter and phar are bundled and compiled into
# PHP by default. If missing, install them directly by `docker-php-ext-install extension_name`

# Notice:
# 1. Mcrypt was DEPRECATED in PHP 7.1.0, and REMOVED in PHP 7.2.0.
# 2. opcache requires PHP version >= 7.0.0.
# 3. soap requires libxml2-dev.
# 4. xml, xmlrpc, wddx require libxml2-dev and libxslt-dev.
# 5. Line `&& :\` is just for better reading and do nothing.
RUN apt-get update \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && :\
    && apt-get install -y libicu-dev \
    && docker-php-ext-install intl \
    && :\
    && apt-get install -y libxml2-dev \
    && apt-get install -y libxslt-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-install xsl \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-install wddx \
    && :\
    && apt-get install -y libbz2-dev \
    && docker-php-ext-install bz2 \
    && :\
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
    && pecl install xdebug-2.6.0 \
    && docker-php-ext-enable xdebug \
    && pecl install redis-3.1.5 \
    && docker-php-ext-enable redis \
    && apt-get install -y libmemcached-dev zlib1g-dev  \
    && pecl install memcached-3.0.4 \
    && docker-php-ext-enable memcached \
    && apt-get install -y openssl libssl-dev  \
    && pecl install mongodb-1.5.2 \
    && docker-php-ext-enable mongodb \
    #yaf pecl安装有bug,只能用源码安装
    && curl -fsSL 'http://pecl.php.net/get/yaf-3.0.6.tgz' -o yaf.tar.gz  \
    && mkdir -p /tmp/yaf  \
    && tar -xf yaf.tar.gz -C /tmp/yaf --strip-components=1  \
    && rm yaf.tar.gz  \
    && pecl install swoole-2.1.0 \
    && docker-php-ext-enable swoole \
    && pecl install protobuf-3.5.1 \
    && docker-php-ext-enable protobuf \
    #xhprof进行线上PHP性能追踪及分析
    && curl -fsSL 'https://github.com/tideways/php-xhprof-extension/archive/v4.1.5.tar.gz' -o xhprof.tar.gz  \
    && mkdir -p /tmp/xhprof \
    && tar -xf xhprof.tar.gz -C /tmp/xhprof --strip-components=1  \
    && rm xhprof.tar.gz \
    && docker-php-ext-configure /tmp/xhprof --enable-xhprof  \
    && docker-php-ext-install /tmp/xhprof  \
    # Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*
