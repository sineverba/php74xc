FROM php:7.4.14-cli

# OpCache settings
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"
ENV XDEBUG_MODE="debug,coverage"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    libpq-dev

# Setup PHPXDebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd opcache zip \
    && docker-php-ext-enable mysqli pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:1.10.19 /usr/bin/composer /usr/bin/composer

# Add custom ini files
COPY config/10-shorttag.ini $PHP_INI_DIR/conf.d/
COPY config/20-memory-limit.ini $PHP_INI_DIR/conf.d/
COPY config/30-opcache.ini $PHP_INI_DIR/conf.d/
COPY config/40-xdebug.ini $PHP_INI_DIR/conf.d/

# Create folder
RUN mkdir -p /data