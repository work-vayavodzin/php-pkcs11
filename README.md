## Simple Docker based playground for php8 pkcs extension (https://github.com/gamringer/php-pkcs11). It works with Soft HSM but potentially can be used with AWS HSM as well.


## Build and run instance with docker
docker build . -t pkcs11
docker run  -p 8090:8090 -v $(pwd)/src/:/var/www/html -it pkcs11 bash

softhsm2-util --init-token --slot 0 --label "Test Token" --pin 123456 --so-pin 12345678
softhsm2-util --show-slots

### Create and store key, {PHP11_SLOT} - should be you own slot identity from output

pkcs11-tool --module /usr/lib/softhsm/libsofthsm2.so -l -p 123456 -k --id 1 --label "Test RSA Key" --key-type rsa:2048  --slot {PHP11_SLOT}

### Export config

export PHP11_MODULE=/usr/lib/softhsm/libsofthsm2.so \
export PHP11_SLOT={PHP11_SLOT} \
export PHP11_PIN=123456

### Test cli

php sign.php

### Test web

php -S 0.0.0.0:8090

http://0.0.0.0:8090/sign.php
