FROM alpine:3.6

MAINTAINER Nicholas Wiersma <nick@wiersma.co.za>

# Set configuration defaults
ENV PHP_WORKERS 2
ENV PHP_MEMORY_LIMIT 128M
ENV PHP_MAX_FILE_UPLOADS 20
ENV PHP_MAX_UPLOAD 50M
ENV PHP_MAX_POST 50M

# Install dependencies
RUN apk --no-cache add \
		bash \
        ca-certificates \
        curl \
        git \
        nginx \
        unzip \
        php7 \
        php7-cgi \
        php7-curl \
        php7-dom \
        php7-fpm \
        php7-json \
        php7-mcrypt \
        php7-mbstring \
        php7-opcache \
        php7-openssl \
        php7-pcntl \
        php7-phar \
        php7-session \
        php7-xml \
        php7-xmlreader \
        php7-zip \
        php7-zlib && \
    rm -rf \
        /var/cache/apk/* \
        /tmp/*

# Configure php
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php7/php.ini
RUN sed -i 's/memory_limit.*/memory_limit = "${PHP_MEMORY_LIMIT}"/' /etc/php7/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf
COPY bin/serve /bin/serve

RUN chmod a+x /bin/serve
RUN mkdir -p /var/run/nginx

# Create WORKDIR
RUN mkdir /app
COPY index.php /app/index.php

# Set WORKDIR
WORKDIR /app

# Expose volumes
VOLUME ["/app"]

# Expose ports
EXPOSE 80

# Entry point
CMD ["serve"]
