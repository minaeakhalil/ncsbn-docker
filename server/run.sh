#!/usr/bin/env bash

cd /var/www/html

composer install

php /var/www/tao/tao/scripts/taoInstall.php \
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

#chmod -R 0777 /var/www/html/taoQtiItem/views/js/portableSharedLibraries \
#    && chmod -R 0777 /var/www/html/data \
#    && chmod -R 0777 /var/www/html/config \
#    && chmod -R 0777 /var/www/html/tao/views/locales \
#    && chmod -R 0777 /var/www/html/tao/views/js \
#    && chmod -R 0777 /var/www/html/tao/views \
#    && chmod -R 0777 /var/www/html/funcAcl/views/build \
#    && chmod -R 0777 /var/www/html/taoBackOffice/views/build \
#    && chmod -R 0777 /var/www/html/taoTestTaker/views/build \
#    && chmod -R 0777 /var/www/html/taoGroups/views/build \
#    && chmod -R 0777 /var/www/html/taoResultServer/views/build \
#    && chmod -R 0777 /var/www/html/taoItems/views/js/test \
#    && chmod -R 0777 /var/www/html/taoItems/views/build \
#    && chmod -R 0777 /var/www/html/taoQtiItem/views/js/test \
#    && chmod -R 0777 /var/www/html/taoQtiItem/views/build \
#    && chmod -R 0777 /var/www/html/qtiItemPci/views/build \
#    && chmod -R 0777

/usr/bin/supervisord -n -c /etc/supervisord.conf
