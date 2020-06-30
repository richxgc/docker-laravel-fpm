FROM php:7.4-fpm

RUN LC_ALL=C.UTF-8 && apt-get -qq update && apt-get -qq install -y libpq-dev libicu-dev libpng-dev libfontconfig1 libxrender1 libxtst6 libzip-dev zip
RUN docker-php-ext-install -j$(nproc) pgsql mysqli pdo_pgsql pdo_mysql bcmath intl gd zip

ADD php.ini "$PHP_INI_DIR/php.ini"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /code

WORKDIR /code

VOLUME /code