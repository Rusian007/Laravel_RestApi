FROM php:7.4-apache

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql php-curl php-sqlite3

# Copy the Apache virtual host configuration file
COPY docker/apache2.conf /etc/apache2/sites-available/000-default.conf

# Copy the Laravel project files into the container
COPY . /var/www/html

# Set the working directory to the Laravel project directory
WORKDIR /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Composer dependencies
RUN composer install

# Set the permissions on the Laravel storage and bootstrap/cache directories
RUN chgrp -R www-data storage bootstrap/cache
RUN chmod -R ug+rwx storage bootstrap/cache

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]

