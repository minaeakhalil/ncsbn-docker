#!/usr/bin/env bash

cat > /etc/httpd/conf.d/localhost.conf <<EOF
<VirtualHost *:80>
    ServerName localhost:80
    ServerAlias localhost
    ServerAdmin admin@breaktech.com

    DocumentRoot ${DOCROOT}
    <Directory ${DOCROOT}>
        # Disable directory index
        Options Indexes FollowSymLinks
        # enable the .htaccess rewrites
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
    ErrorLog "/var/log/httpd/localhost-error_log"
    CustomLog "/var/log/httpd/localhost-access_log" common
</VirtualHost>
EOF

sed -i -e "s|</VirtualHost>||" /etc/httpd/conf.d/ssl.conf

cat >> /etc/httpd/conf.d/ssl.conf <<EOF
    DocumentRoot ${DOCROOT}
    <Directory ${DOCROOT}>
        # Disable directory index
        Options Indexes FollowSymLinks
        # enable the .htaccess rewrites
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
    ErrorLog "/var/log/httpd/localhost_ssl-error_log"
    # CustomLog "/var/log/httpd/localhost_ssl-access_log" common
</VirtualHost>
EOF
