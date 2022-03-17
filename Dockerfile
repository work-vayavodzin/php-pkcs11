FROM php:8.1-fpm
RUN apt-get update && apt-get install -y \
        && mkdir -p /usr/src/php/ext/pkcs \
        && curl -fsSL https://github.com/gamringer/php-pkcs11/archive/refs/heads/master.tar.gz | tar xvz -C /usr/src/php/ext/pkcs --strip 1 \
        && cd /usr/src/php/ext/pkcs \
        && phpize \
        && ./configure \
        && make \
       && docker-php-ext-install pkcs

RUN apt-get install -y softhsm2 \
    && apt-get install -y opensc \
    && mkdir -p /home/user/.softhsm \
    && mkdir -p ~/.config/softhsm2 \
    && touch ~/.config/softhsm2/softhsm2.conf \
    && echo "directories.tokendir = /home/user/.softhsm \
             objectstore.backend = file \
             log.level = INFO \
             slots.removable = false \
             slots.mechanisms = ALL" > softhsm2.conf
