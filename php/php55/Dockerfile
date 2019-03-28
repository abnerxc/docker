FROM php:5.5-fpm

COPY ./sources.list.jessie /etc/apt/sources.list

# Extensions: ctype, dom, fileinfo, ftp, hash, iconv, json, pdo, pdo_sqlite, session,
# tokenizer, simplexml, xml, xmlreader, xmlwriter and phar are bundled and compiled into
# PHP by default. If missing, install them directly by `docker-php-ext-install extension_name`

# Notice:
# 1. Mcrypt was DEPRECATED in PHP 7.1.0, and REMOVED in PHP 7.2.0.
# 2. opcache requires PHP version >= 7.0.0.
# 3. soap requires libxml2-dev.
# 4. xml, xmlrpc, wddx require libxml2-dev and libxslt-dev.
# 5. Line `&& :\` is just for better reading and do nothing.
#RUN apt-get clean && apt-get update \
#    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
#    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
#    && docker-php-ext-install gd \
#    && apt-get install -y libicu-dev \
#    && docker-php-ext-install intl \
#    && apt-get install -y libxml2-dev \
#    && apt-get install -y libxslt-dev \
#    && docker-php-ext-install soap \
#    && docker-php-ext-install xsl \
#    && docker-php-ext-install xmlrpc \
#    && docker-php-ext-install wddx \
#    && apt-get install -y libbz2-dev \
#    && docker-php-ext-install bz2 \
#    && docker-php-ext-install zip \
#    && docker-php-ext-install pcntl \
#    && docker-php-ext-install pdo_mysql \
#    && docker-php-ext-install mysqli \
#    && docker-php-ext-install mbstring \
#    && docker-php-ext-install exif \
#    && docker-php-ext-install bcmath \
#    && docker-php-ext-install calendar \
#    && docker-php-ext-install sockets \
#    && docker-php-ext-install gettext \
#    && docker-php-ext-install shmop \
#    && docker-php-ext-install sysvmsg \
#    && docker-php-ext-install sysvsem \
#    && docker-php-ext-install sysvshm \
#    && docker-php-ext-install opcache \
#    && docker-php-ext-install ctype \
#    && docker-php-ext-install dom \
#    && apt-get install -y libenchant-dev \
#    && docker-php-ext-install enchant \
#    && docker-php-ext-install dba \
#    && docker-php-ext-install fileinfo \
#    && apt-get install -y libc-client-dev libkrb5-dev \
#    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
#    && docker-php-ext-install imap \
#    && docker-php-ext-install mysql \
#    && docker-php-ext-install pdo \
#    && apt-get install -y libmcrypt-dev \
#    && docker-php-ext-install mcrypt \
#    && apt-get install -y libgmp-dev \
#    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
#    && docker-php-ext-install gmp \
#    && apt-get install -y unixodbc-dev \
#    && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
#    && docker-php-ext-install pdo_odbc \
#    && apt-get install -y libpq-dev \
#    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
#    && docker-php-ext-install  pdo_pgsql pgsql \
#    && apt-get install -y libsqlite3-dev \
#    && docker-php-ext-install pdo_sqlite \
##    && apt-get install -y libsnmp-dev snmp \
##    && docker-php-ext-install snmp \
#    && :\
#    && apt-get install -y libpspell-dev aspell-en \
#    && docker-php-ext-install pspell \
#    && :\
#    && apt-get install -y librecode0 librecode-dev \
#    && docker-php-ext-install recode \
#    && :\
#    && apt-get install -y libtidy-dev \
#    && docker-php-ext-install tidy \
#    && :\
#    && apt-get install -y libc-client-dev libkrb5-dev \
#    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
#    && docker-php-ext-install imap \
#    && :\
#    && apt-get install -y libc-client-dev libkrb5-dev \
#    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
#    && docker-php-ext-install imap \
#    && :\
#    && apt-get install -y firebird-dev \
#    && docker-php-ext-configure interbase \
#    && docker-php-ext-install interbase  \
#    && :\
#    && apt-get install -y libldap2-dev \
#    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
#    && docker-php-ext-install ldap \
#    && :\
#    && apt-get install -y freetds-bin freetds-dev freetds-common \
#    && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ \
#    && docker-php-ext-configure mssql && docker-php-ext-install mssql \
#    #&& :\
#    #&& apt-get install -y postgresql-client \
#    #&& apt-get install -y mysql-client \
#    #&& :\
#    #&& apt-get install -y libc-client-dev \
#    #&& docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
#    #&& docker-php-ext-install imap \
#    #&& :\
#    #&& apt-get install -y libldb-dev \
#    #&& apt-get install -y libldap2-dev \
#    #&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
#    #&& docker-php-ext-install ldap \
#    && rm -rf /var/lib/apt/lists/*
#
## Composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Install extension using pecl
# Notice: if pecl install get error
#    `No releases available for package "pecl.php.net/xxx"`
# or
#    `Package "xxx" does not have REST xml available`
# Please turn on proxy (The proxy IP may be docker host IP or others):
#  pecl install http://pecl.php.net/get/xdebug-2.2.1.tgz  或者使用这种方式
#RUN pear config-set http_proxy http://10.0.75.1:1080
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

#RUN pecl install http://pecl.php.net/get/xdebug-2.2.7.tgz \
#    && docker-php-ext-enable xdebug \
RUN pecl install http://pecl.php.net/get/redis-3.1.5.tgz \
    && docker-php-ext-enable redis \
    && pecl install http://pecl.php.net/get/memcache-2.2.3.tgz \
    && docker-php-ext-enable memcache \
    && apt-get install -y libmemcached-dev zlib1g-dev  \
    && pecl install http://pecl.php.net/get/memcached-2.2.0.tgz \
    && docker-php-ext-enable memcached \
    && apt-get install -y openssl libssl-dev  \
    && pecl install http://pecl.php.net/get/mongo-1.6.0.tgz \
    && docker-php-ext-enable mongo \
    && apt-get install -y openssl libssl-dev  \
    && pecl install http://pecl.php.net/get/mongodb-1.3.0.tgz \
    && docker-php-ext-enable mongodb \
    && pecl install http://pecl.php.net/get/yaf-2.3.5.tgz \
    && docker-php-ext-enable yaf \
    && apt-get install -y git \
    && cd /tmp && git clone --depth 1 git://github.com/phalcon/cphalcon.git \
    && cd cphalcon/build &&  ./install \
    && docker-php-ext-enable phalcon \
    && pecl install http://pecl.php.net/get/swoole-1.10.1.tgz \
    && docker-php-ext-enable swoole \
    && pecl install http://pecl.php.net/get/protobuf-3.3.0.tgz \
    && docker-php-ext-enable protobuf \
    && pecl install http://pecl.php.net/get/xhprof-0.9.4.tgz \
    && docker-php-ext-enable xhprof \
    && rm -rf /tmp/*