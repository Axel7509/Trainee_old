FROM php:7.2-apache

COPY info.php /var/www/html/info.php

COPY 000-default.conf /etc/apache2/sites-available

COPY apache2.conf /etc/apache2

COPY ports.conf /etc/apache2

EXPOSE 8081

CMD ["apache2-foreground"]