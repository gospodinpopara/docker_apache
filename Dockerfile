# Use the official PHP image as the base image
FROM php:8.3-apache

# Install necessary PHP extensions and other dependencies
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli pdo pdo_mysql zip \
    && a2enmod rewrite

#Composer installation
ENV COMPOSER_ALLOW_SUPERUSER=1
COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer
COPY ./app/composer.* ./

RUN composer install --prefer-dist --no-dev --no-scripts --no-progress --no-interaction

# Install node JS + YARN (vrv bi se moglo instalirati kao poseban service ali je i ovo okej)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global yarn

# custom V-host config
COPY services/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Copy application code to the Apache document root
COPY app/ /var/www/html/

RUN composer dump-autoload --optimize

# Set the working directory
WORKDIR /var/www/html/

# Expose port 80
EXPOSE 80

CMD ["apache2-foreground"]
