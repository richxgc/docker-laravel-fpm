FROM php:7.4-fpm

RUN LC_ALL=C.UTF-8 && apt-get -qq update && apt-get -qq install -y libpq-dev libicu-dev libpng-dev libfontconfig1 libxrender1 libxtst6 libzip-dev libfreetype6-dev libjpeg62-turbo-dev zip cron

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) pgsql pdo_pgsql bcmath intl gd zip opcache exif

COPY php.ini "$PHP_INI_DIR/php.ini"
COPY www.conf "/usr/local/etc/php-fpm.d/www.conf"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /code

WORKDIR /code

VOLUME /code