# Use OpenResty as the base image with Ubuntu 20.04 (Focal)
FROM openresty/openresty:1.21.4.1-0-focal

# Add the Ondřej Surý PPA repository for PHP 8.0
RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:ondrej/php && \
  apt-get update

# Install PHP 8.0, PHP-FPM, and necessary extensions
RUN apt-get install -y php8.0-fpm php8.0-mbstring php8.0-xml php8.0-mysqli \
  php8.0-opcache php8.0-gd php8.0-curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy OpenResty configuration files
COPY config/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY config/default.conf /etc/nginx/conf.d/default.conf
COPY config/access_checker.lua /usr/local/openresty/nginx/access_checker.lua

# Copy PHP configuration files
COPY php/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf

# Create necessary directories and set permissions
RUN mkdir -p /var/www/html
COPY php/index /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 for web traffic
EXPOSE 80

# Start PHP-FPM in the background and OpenResty in the foreground
CMD ["sh", "-c", "service php8.0-fpm start && openresty -g 'daemon off;'"]
