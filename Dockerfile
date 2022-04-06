FROM php:8.1-fpm
RUN apt-get update && apt-get install -y \
    && mkdir -p /usr/src/php/ext/pkcs \
    && curl -fsSL https://github.com/gamringer/php-pkcs11/archive/refs/heads/master.tar.gz | tar xvz -C /usr/src/php/ext/pkcs --strip 1 \
    && cd /usr/src/php/ext/pkcs \
    && phpize \
    && ./configure \
    && make \
    && docker-php-ext-install pkcs

RUN apt-get update && apt-get -y install wget \
    libmd0 libbsd0 libedit2 python-is-python3 \
    && wget http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1_amd64.deb \
    && apt-get -y install ./multiarch-support_2.27-3ubuntu1_amd64.deb \
    && wget http://mirrors.kernel.org/ubuntu/pool/main/j/json-c/libjson-c2_0.11-4ubuntu2_amd64.deb \
    && apt-get -y install ./libjson-c2_0.11-4ubuntu2_amd64.deb \
    && wget https://s3.amazonaws.com/cloudhsmv2-software/CloudHsmClient/Xenial/cloudhsm-client_latest_amd64.deb \
    && apt-get -y install ./cloudhsm-client_latest_amd64.deb