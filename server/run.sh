#!/usr/bin/env bash

# Install TAO
composer install -d ${DOCROOT} \
    && php ${DOCROOT}/tao/scripts/taoInstall.php \
        --db_driver pdo_mysql \
        --db_host ${MYSQL_HOST} \
        --db_name ${TAO_MYSQL_DB} \
        --db_user ${TAO_MYSQL_USER} \
        --db_pass ${TAO_MYSQL_PASSWORD} \
        --module_namespace http://sample/first.rdf \
        --module_url ${TAO_FULL_URL} \
        --user_login ${TAO_USER} \
        --user_pass ${TAO_PASSWORD} \
        -e taoCe \
    && php ${DOCROOT}/tao/scripts/taoUpdate.php \
    && /usr/bin/supervisord -n -c /etc/supervisord.conf
