#!/usr/bin/env bash

# Install TAO
composer install -d /var/www/html \
    && php /var/www/html/tao/scripts/taoInstall.php \
        --db_driver pdo_mysql \
        --db_host mysql \
        --db_name taoUnitTest \
        --db_user root \
        --db_pass test123 \
        --module_namespace http://sample/first.rdf \
        --module_url https://tao:4443 \
        --user_login admin \
        --user_pass admin \
        -e taoCe \
    && php /var/www/html/tao/scripts/taoUpdate.php \
    && /usr/bin/supervisord -n -c /etc/supervisord.conf
