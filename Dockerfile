# PHP Image for Laravel (PHP 8.3 and Composer)
FROM php:8.3-fpm

# Working Directory
WORKDIR /var/www

# Install Dependencies
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    unzip \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install gd mbstring pdo pdo_mysql xml

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy Laravel Files
COPY . /var/www

# File and Authorization for Laravel
RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# Start Service for Laravel
CMD ["php-fpm"]
