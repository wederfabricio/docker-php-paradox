FROM php:5.6.9-fpm

RUN mkdir -p /files

COPY paradox.tar /tmp

RUN tar xvf /tmp/paradox.tar -C /files

RUN docker-php-ext-install mysql pdo_mysql

RUN apt-get update && apt-get install -y php-pear php5-dev pxlib1 pxlib-dev && cd /files/paradox/paradox-1.4.3 && pecl config-set php_ini $PHP_INI_DIR/php.ini && phpize && ./configure && make && make install && echo "extension=paradox.so" > /usr/local/etc/php/conf.d/paradox.ini

RUN rm -rf /tmp/paradox.tar && rm -rf /files && kill -USR2 1

CMD ["php-fpm"]

EXPOSE 9000
