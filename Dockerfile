FROM alpine:3.6

MAINTAINER Nicholas Wiersma <nick@wiersma.co.za>

# Set configuration defaults
ENV PHP_MEMORY_LIMIT 512M
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOADS 20
ENV PHP_MAX_POST 50M

# Install dependencies
RUN apk --no-cache add \
        ca-certificates \
        git \
        curl \
        unzip \
        nginx \
        php7 \
        php7-fpm \
        php7-xml \
        php7-zip \
        php7-xmlreader \
        php7-zlib \
        php7-opcache \
        php7-mcrypt \
        php7-openssl \
        php7-curl \
        php7-json \
        php7-dom \
        php7-phar \
        php7-mbstring \
        php7-cgi \
        php7-pcntl && \
    rm -rf \
        /var/cache/apk/* \
        /tmp/*

# Configure php fpm
RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf

# Configure php
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php7/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/default.conf /etc/nginx/conf.d/default.conf
COPY files/serve.sh /serve.sh

RUN chmod a+x /serve.sh
RUN mkdir -p /var/run/nginx

# Create WORKDIR
RUN mkdir /app
COPY files/index.php /app/index.php

# Set WORKDIR
WORKDIR /app

# Expose volumes
VOLUME ["/app"]

# Expose ports
EXPOSE 80

# Entry point
CMD ["/serve.sh"]
