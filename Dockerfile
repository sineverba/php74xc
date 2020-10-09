FROM php:7.4.11-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libpq-dev

# Setup PHPXDebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd \
    && docker-php-ext-enable mysqli pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:1.10.13 /usr/bin/composer /usr/bin/composer

# Add custom ini files
COPY config/10-shorttag.ini $PHP_INI_DIR/conf.d/
COPY config/20-memory-limit.ini $PHP_INI_DIR/conf.d/

# Create folder
RUN mkdir -p /data