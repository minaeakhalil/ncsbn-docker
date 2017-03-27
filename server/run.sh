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
#        --module_url https://tao:4443 \
#        --user_login admin \
#        --user_pass admin \
#        -e taoCe \
#    && php /var/www/html/tao/scripts/taoUpdate.php \
#    && /usr/bin/supervisord -n -c /etc/supervisord.conf

# Setting up SSH configuration
if [ "${AUTHORIZED_KEYS}" != "**None**" ]; then
    echo "=> Found authorized keys"
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    IFS=$'\n'

    arr=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x |sed -e 's/^ *//' -e 's/ *$//')
        cat /root/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to /root/.ssh/authorized_keys: $x"
            echo "$x" >> /root/.ssh/authorized_keys
        fi
    done
fi
if [ ! -f /.root_pw_set ]; then
    /set_root_pw.sh
fi
exec /usr/sbin/sshd -D


/usr/bin/supervisord -n -c /etc/supervisord.conf
