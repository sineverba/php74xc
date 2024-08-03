ARG COMPOSER_VERSION
FROM composer:$COMPOSER_VERSION AS composer_downloader
FROM php:7.4.33-cli
ARG XDEBUG_VERSION 
ARG MCRYPT_VERSION 
# OpCache settings
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"
ENV XDEBUG_MODE="debug,coverage"

# Install system dependencies
RUN apt-get update -y && apt-get install -y \
    git \
    curl \
    libmcrypt-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    libpq-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Setup PHPXDebug
RUN pecl install xdebug-${XDEBUG_VERSION} mcrypt-${MCRYPT_VERSION}
# add redis
RUN pecl install redis && docker-php-ext-enable redis

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd opcache zip \
    && docker-php-ext-enable mysqli pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd xdebug mcrypt

# Get latest Composer
COPY --from=composer_downloader /usr/bin/composer /usr/bin/composer

# Add custom ini files
COPY config/10-shorttag.ini \
        config/20-memory-limit.ini \
        config/30-opcache.ini \
        config/40-xdebug.ini \      
        $PHP_INI_DIR/conf.d/

# Create folder
RUN mkdir -p /data