FROM php:5.6-fpm

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
RUN apt-get clean && apt-get update \
    && apt-get install -y -no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && apt-get install -y -no-install-recommends libicu-dev \
    && docker-php-ext-install intl \
    && apt-get install -y -no-install-recommends libxml2-dev \
    && apt-get install -y -no-install-recommends libxslt-dev \
    && docker-php-ext-install soap \
    && docker-php-ext-install xsl \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-install wddx \
    && apt-get install -y -no-install-recommends libbz2-dev \
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
    && docker-php-ext-install ctype \
    && docker-php-ext-install dom \
    && apt-get install -y -no-install-recommends libenchant-dev \
    && docker-php-ext-install enchant \
    && docker-php-ext-install dba \
    && docker-php-ext-install fileinfo \
    && apt-get install -y -no-install-recommends libc-client-dev libkrb5-dev \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-install mysql \
    && docker-php-ext-install pdo \
    && apt-get install -y -no-install-recommends libmcrypt-dev \
    && docker-php-ext-install mcrypt \
    && apt-get install -y -no-install-recommends libgmp-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && docker-php-ext-install gmp \
    && apt-get install -y -no-install-recommends unixodbc-dev \
    && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
    && docker-php-ext-install pdo_odbc \
    && apt-get install -y -no-install-recommends libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install  pdo_pgsql pgsql \
    && apt-get install -y -no-install-recommends libsqlite3-dev \
    && docker-php-ext-install pdo_sqlite \
    && :\
    && apt-get install -y -no-install-recommends libpspell-dev aspell-en \
    && docker-php-ext-install pspell \
    && :\
    && apt-get install -y -no-install-recommends librecode0 librecode-dev \
    && docker-php-ext-install recode \
    && :\
    && apt-get install -y -no-install-recommends libtidy-dev \
    && docker-php-ext-install tidy \
    && :\
    && apt-get install -y -no-install-recommends libc-client-dev libkrb5-dev \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && :\
    && apt-get install -y -no-install-recommends libc-client-dev libkrb5-dev \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && :\
    && apt-get install -y -no-install-recommends firebird-dev \
    && docker-php-ext-configure interbase \
    && docker-php-ext-install interbase  \
    && :\
    && apt-get install -y -no-install-recommends libldap2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \
    && :\
    && apt-get install -y -no-install-recommends freetds-bin freetds-dev freetds-common \
    && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ \
    && docker-php-ext-configure mssql && docker-php-ext-install mssql \
    && :\
    #pecl扩展开始开始
    && pecl channel-update pecl.php.net \
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-enable xdebug \
    && pecl install redis-3.1.5 \
    && docker-php-ext-enable redis \
    && pecl install memcache-2.2.7 \
    && docker-php-ext-enable memcache \
    && apt-get install -y -no-install-recommends libmemcached-dev zlib1g-dev  \
    && pecl install memcached-2.2.0 \
    && docker-php-ext-enable memcached \
    && apt-get install -y -no-install-recommends openssl libssl-dev  \
    && pecl install mongo-1.6.16 \
    && docker-php-ext-enable mongo \
    && apt-get install -y -no-install-recommends openssl libssl-dev  \
    && pecl install mongodb-1.3.0 \
    && docker-php-ext-enable mongodb \
    && pecl install yaf-2.2.5 \
    && docker-php-ext-enable yaf \
    && apt-get install -y -no-install-recommends git \
    && cd /tmp && git clone --depth 1 git://github.com/phalcon/cphalcon.git \
    && cd cphalcon/build &&  ./install \
    && docker-php-ext-enable phalcon \
    && pecl install swoole-1.10.1 \
    && docker-php-ext-enable swoole \
    && pecl install protobuf-3.3.0 \
    && docker-php-ext-enable protobuf \
    && pecl install xhprof-0.9.4 \
    && docker-php-ext-enable xhprof \
    # Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*
