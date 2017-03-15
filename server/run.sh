#!/usr/bin/env bash

cd /var/www/html

# Install TAO dependencies using Composer
composer install

# Install TAO
php /var/www/html/scripts/taoInstall.php \
        --db_driver pdo_mysql \
        --db_host mysql \
        --db_name taoUnitTest \
        --db_user root \
        --db_pass test123 \
        --module_namespace http://sample/first.rdf \
        --module_url http://tao \
        --user_login admin \
        --user_pass admin \
        -e taoCe

# Run TAO Update right after installation
php /var/www/html/scripts/taoUpdate

# Run SupervisorD which would start Apache Server
/usr/bin/supervisord -n -c /etc/supervisord.conf
