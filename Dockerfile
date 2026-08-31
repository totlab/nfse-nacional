FROM php:8.3-apache

RUN apt-get update && apt-get upgrade -y

# Install linux utilities.
RUN apt-get install -y vim nano iputils-ping git libzip-dev zip unzip npm default-mysql-client
RUN apt-get install -y libicu-dev libxml2-dev

# Enable mod_rewrite and SSL.
RUN a2enmod rewrite
RUN a2enmod ssl

# Composer install
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# AMQP install
# RUN apt-get install -y \
#         librabbitmq-dev \
#         libssh-dev \
#     && docker-php-ext-install \
#         bcmath \
#         sockets \
#     && pecl install amqp-1.11.0 \
#     && docker-php-ext-enable amqp

# RUN apt-get update && apt-get install -y \
#         libfreetype-dev \
#         libjpeg62-turbo-dev \
#         libpng-dev \
#         libwebp-dev \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
#     && docker-php-ext-install gd

# Lock install.
RUN docker-php-ext-install sysvsem

# Install soap
RUN docker-php-ext-install soap


# PHP Extensions install
RUN docker-php-ext-install mysqli pdo pdo_mysql intl zip
RUN docker-php-ext-enable intl

# ls aliases.
RUN echo "alias ll='ls -alF'" >> ~/.bashrc
RUN echo "alias la='ls -A'" >> ~/.bashrc
RUN echo "alias l='ls -CF'" >> ~/.bashrc

RUN echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/custom-memory-limit.ini

WORKDIR /var/www/nfsenacional

# Symfony config.
RUN rm -rf /var/www/html && \
    ln -s /var/www/nfsenacional/public /var/www/html
