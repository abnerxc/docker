FROM php:5.5-fpm

#COPY ./sources.list.jessie /etc/apt/sources.list

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
    #&& docker-php-ext-install pdo_firebird \
    #&& docker-php-ext-install pdo_dblib \
    #&& docker-php-ext-install pdo_oci \
    #&& docker-php-ext-install pdo_odbc \
    #&& docker-php-ext-install pdo_pgsql \
    #&& docker-php-ext-install pgsql \
    #&& docker-php-ext-install oci8 \
    #&& docker-php-ext-install odbc \
    #&& docker-php-ext-install dba \
    #&& docker-php-ext-install interbase \
    && :\
    && apt-get install -y libmcrypt-dev \
    && docker-php-ext-install mcrypt
    #&& :\
    #&& apt-get install -y curl \
    #&& apt-get install -y libcurl3 \
    #&& apt-get install -y libcurl4-openssl-dev \
    #&& docker-php-ext-install curl \
    #&& :\
    #&& apt-get install -y libreadline-dev \
    #&& docker-php-ext-install readline \
    #&& :\
    #&& apt-get install -y libsnmp-dev \
    #&& apt-get install -y snmp \
    #&& docker-php-ext-install snmp \
    #&& :\
    #&& apt-get install -y libpspell-dev \
    #&& apt-get install -y aspell-en \
    #&& docker-php-ext-install pspell \
    #&& :\
    #&& apt-get install -y librecode0 \
    #&& apt-get install -y librecode-dev \
    #&& docker-php-ext-install recode \
    #&& :\
    #&& apt-get install -y libtidy-dev \
    #&& docker-php-ext-install tidy \
    #&& :\
    #&& apt-get install -y libgmp-dev \
    #&& ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    #&& docker-php-ext-install gmp \
    #&& :\
    #&& apt-get install -y postgresql-client \
    #&& apt-get install -y mysql-client \
    #&& :\
    #&& apt-get install -y libc-client-dev \
    #&& docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    #&& docker-php-ext-install imap \
    #&& :\
    #&& apt-get install -y libldb-dev \
    #&& apt-get install -y libldap2-dev \
    #&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    #&& docker-php-ext-install ldap \

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Install extension using pecl
# Notice: if pecl install get error
#    `No releases available for package "pecl.php.net/xxx"`
# or
#    `Package "xxx" does not have REST xml available`
# Please turn on proxy (The proxy IP may be docker host IP or others):
#RUN pear config-set http_proxy http://10.0.75.1:1080
#
#RUN pecl install redis-3.1.4 \
#    && docker-php-ext-enable redis \
#    && :\
#    && pecl install xdebug-2.5.5 \
#    && docker-php-ext-enable xdebug \
#    && :\
#    && apt-get install -y libmagickwand-dev \
#    && pecl install imagick-3.4.3 \
#    && docker-php-ext-enable imagick \
#    && :\
#    && apt-get install -y libmemcached-dev zlib1g-dev \
#    && pecl install memcached-2.2.0 \
#    && docker-php-ext-enable memcached

RUN curl -fsSL 'https://xdebug.org/files/xdebug-2.5.5.tgz' -o xdebug.tar.gz \
    && mkdir -p /tmp/xdebug  \
    && tar -xf xdebug.tar.gz -C /tmp/xdebug --strip-components=1  \
    && rm xdebug.tar.gz  \
    && docker-php-ext-configure /tmp/xdebug --enable-xdebug  \
    && docker-php-ext-install /tmp/xdebug  \

    #redis
    && curl -fsSL 'http://pecl.php.net/get/redis-3.1.5.tgz' -o redis.tar.gz  \
    && mkdir -p /tmp/redis \
    && tar -xf redis.tar.gz -C /tmp/redis --strip-components=1  \
    && rm redis.tar.gz \
    && docker-php-ext-configure /tmp/redis --enable-redis  \
    && docker-php-ext-install /tmp/redis  \
    #memcache
    && curl -fsSL 'http://pecl.php.net/get/memcache-2.2.7.tgz' -o memcache.tar.gz  \
    && mkdir -p /tmp/memcache \
    && tar -xf memcache.tar.gz -C /tmp/memcache --strip-components=1  \
    && rm memcache.tar.gz \
    && docker-php-ext-configure /tmp/memcache --enable-memcache  \
    && docker-php-ext-install /tmp/memcache  \
    #memcached
    && apt-get install -y libmemcached-dev zlib1g-dev  \
    && curl -fsSL 'http://pecl.php.net/get/memcached-2.2.0.tgz' -o memcached.tar.gz  \
    && mkdir -p /tmp/memcached \
    && tar -xf memcached.tar.gz -C /tmp/memcached --strip-components=1 \
    && rm memcached.tar.gz \
    && docker-php-ext-configure /tmp/memcached --enable-memcached \
    && docker-php-ext-install /tmp/memcached  \
    #mongo
    && apt-get install -y openssl libssl-dev  \
    && curl -fsSL 'http://pecl.php.net/get/mongo-1.6.16.tgz' -o mongo.tar.gz  \
    && mkdir -p /tmp/mongo  \
    && tar -xf mongo.tar.gz -C /tmp/mongo --strip-components=1  \
    && rm mongo.tar.gz  \
    && docker-php-ext-configure /tmp/mongo --enable-mongo  \
    && docker-php-ext-install /tmp/mongo \
    #mongodb
    && apt-get install -y openssl libssl-dev  \
    && curl -fsSL 'http://pecl.php.net/get/mongodb-1.3.0.tgz' -o mongodb.tar.gz  \
    && mkdir -p /tmp/mongodb  \
    && tar -xf mongodb.tar.gz -C /tmp/mongodb --strip-components=1  \
    && rm mongodb.tar.gz  \
    && docker-php-ext-configure /tmp/mongodb --enable-mongodb  \
    && docker-php-ext-install /tmp/mongodb \
    #yaf
    && curl -fsSL 'http://pecl.php.net/get/yaf-2.3.5.tgz' -o yaf.tar.gz  \
    && mkdir -p /tmp/yaf  \
    && tar -xf yaf.tar.gz -C /tmp/yaf --strip-components=1  \
    && rm yaf.tar.gz  \
    && docker-php-ext-configure /tmp/yaf --enable-yaf  \
    && docker-php-ext-install /tmp/yaf \
    #phalcon
    && apt-get install -y git \
    && cd /tmp && git clone --depth 1 git://github.com/phalcon/cphalcon.git \
    && cd cphalcon/build &&  ./install \
    && docker-php-ext-enable phalcon \
    #swoole
    && curl -fsSL 'http://pecl.php.net/get/swoole-1.10.1.tgz' -o swoole.tar.gz  \
    && mkdir -p /tmp/swoole \
    && tar -xf swoole.tar.gz -C /tmp/swoole --strip-components=1  \
    && rm swoole.tar.gz \
    && docker-php-ext-configure /tmp/swoole --enable-swoole  \
    && docker-php-ext-install /tmp/swoole  \

    #RPC通讯协议protobuf
    && curl -fsSL 'http://pecl.php.net/get/protobuf-3.5.1.tgz' -o protobuf.tar.gz  \
    && mkdir -p /tmp/protobuf \
    && tar -xf protobuf.tar.gz -C /tmp/protobuf --strip-components=1  \
    && rm protobuf.tar.gz \
    && docker-php-ext-configure /tmp/protobuf --enable-protobuf  \
    && docker-php-ext-install /tmp/protobuf  \

    #xhprof
    && curl -fsSL 'http://pecl.php.net/get/xhprof-0.9.4.tgz' -o xhprof.tar.gz  \
    && mkdir -p /tmp/xhprof \
    && tar -xf xhprof.tar.gz -C /tmp/xhprof --strip-components=1  \
    && rm xhprof.tar.gz \
    && docker-php-ext-configure /tmp/xhprof/extension --enable-xhprof  \
    && docker-php-ext-install /tmp/xhprof/extension  \


    #删除无用包
    && rm -rf /tmp/*