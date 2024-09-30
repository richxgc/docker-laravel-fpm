FROM php:7.4.33-fpm

RUN LC_ALL=C.UTF-8 && apt-get -qq update && apt-get -qq install -y libpq-dev libicu-dev libpng-dev libfontconfig1 libxrender1 libxtst6 libzip-dev libfreetype6-dev libjpeg62-turbo-dev zip cron xfonts-utils xz-utils fontconfig libx11-dev libxext6 libxrender-dev libssl-dev xfonts-75dpi xfonts-base tzdata

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) pgsql pdo_pgsql bcmath intl gd zip opcache exif sockets
RUN pecl install timezonedb && docker-php-ext-enable timezonedb

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -L -o wkhtmltox_0.12.6.1-2.bullseye_amd64.deb https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.bullseye_amd64.deb \
    && dpkg -i wkhtmltox_0.12.6.1-2.bullseye_amd64.deb \
    && apt-get -f install -y \
    && rm wkhtmltox_0.12.6.1-2.bullseye_amd64.deb

COPY php.ini "$PHP_INI_DIR/php.ini"
COPY www.conf "/usr/local/etc/php-fpm.d/www.conf"

RUN mkdir /code
WORKDIR /code
VOLUME /code
