#!/usr/bin/env bash

cd /var/www/html

# Install TAO dependencies using Composer

# Install TAO
#composer install \
#    && php /var/www/html/tao/scripts/taoInstall.php \
#        --db_driver pdo_mysql \
#        --db_host mysql \
#        --db_name taoUnitTest \
#        --db_user root \
#        --db_pass test123 \
#        --module_namespace http://sample/first.rdf \
#        --module_url http://tao:8080 \
#        --user_login admin \
#        --user_pass admin \
#        -e taoCe \
#    && php /var/www/html/tao/scripts/taoUpdate.php \
#    && /usr/bin/supervisord -n -c /etc/supervisord.conf
    
# Start supervisor.d
/usr/bin/supervisord -n -c /etc/supervisord.conf
