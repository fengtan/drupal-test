FROM php:7.4-apache-buster

ENV DEBIAN_FRONTEND=noninteractive
RUN \
  apt-get update && \
  apt-get -y install --no-install-recommends apt-utils dialog 2>&1 && \
  apt-get -y install \
    git \
    less \
    mariadb-client \
    python \
    sudo \
    unzip \
    vim \
    wget && \
  apt-get -y install --no-install-recommends \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libzip-dev && \
  rm -rf /var/lib/apt/lists/*

ENV APACHE_LISTEN_PORT=8080
RUN sed -i "s/80/$APACHE_LISTEN_PORT/g" $APACHE_CONFDIR/sites-available/000-default.conf $APACHE_CONFDIR/ports.conf
EXPOSE ${APACHE_LISTEN_PORT}

ENV APACHE_DOCUMENT_ROOT /var/www/web
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g'     /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN rm -r /var/www/html
WORKDIR /var/www

RUN \
  a2enmod rewrite && \
  docker-php-ext-configure gd \
    --with-freetype \
    -with-jpeg=/usr && \
  docker-php-ext-install -j "$(nproc)" \
    gd \
    pdo_mysql \
    zip && \
  cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
ENV PATH=$PATH:/var/www/vendor/bin

COPY . /var/www
RUN composer --working-dir=/var/www install --no-dev
RUN \
  chgrp -R 0 /var/www && \
  chmod -R g=u /var/www

ENV DEBIAN_FRONTEND=dialog
