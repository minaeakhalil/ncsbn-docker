#!/usr/bin/env bash

# This was tested on TAO 3.1.0 sprint15 and TAO 3.0 RC7
if [ ${TAO_INSTALL} == "yes" ]; then
    # Git is required for Composer to run
    yum install -y git

    # Install TAO
    composer install -d ${DOCROOT} \
        && php ${DOCROOT}/tao/scripts/taoInstall.php \
            --db_driver pdo_mysql \
            --db_host ${MYSQL_HOST} \
            --db_name ${TAO_MYSQL_DB} \
            --db_user ${TAO_MYSQL_USER} \
            --db_pass ${TAO_MYSQL_PASSWORD} \
            --module_namespace ${TAO_MODULE_URL} \
            --module_url ${TAO_FULL_URL} \
            --user_login ${TAO_USER} \
            --user_pass ${TAO_PASSWORD} \
            -e taoCe \
        && php ${DOCROOT}/tao/scripts/taoUpdate.php
fi

# Startup Supervisord and start whatever processes attached to it
/usr/bin/supervisord -n -c /etc/supervisord.conf
