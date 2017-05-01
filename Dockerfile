FROM alpine:3.5

MAINTAINER Nicholas Wiersma <nick@wiersma.co.za>

# Set configuration defaults
ENV PHP_MEMORY_LIMIT 512M
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M

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
    ln -s /usr/bin/php7 /usr/bin/php && \
    rm -rf \
        /var/cache/apk/* \
        /tmp/*

# Configure php fpm
RUN sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf

# Configure php form env vars
RUN sed -i "s|memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|" /etc/php7/php.ini && \
  	sed -i "s|upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|" /etc/php7/php.ini && \
  	sed -i "s|max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|" /etc/php7/php.ini && \
  	sed -i "s|post_max_size =.*|max_file_uploads = ${PHP_MAX_POST}|" /etc/php7/php.ini && \
  	sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php7/php.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

COPY files/nginx.conf /etc/nginx/nginx.conf
COPY files/default.conf /etc/nginx/conf.d/default.conf
COPY files/start.sh /start.sh

RUN chmod a+x /start.sh
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
CMD ["/start.sh"]
