#!/usr/bin/env bash

cat > /etc/httpd/conf.d/localhost.conf <<EOF
<VirtualHost *:80>
    ServerName localhost:80
    ServerAlias localhost
    ServerAdmin admin@breaktech.com

    DocumentRoot /var/www/html
    <Directory /var/www/html>
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

cp /etc/httpd/conf.d/ssl.conf /etc/httpd/conf.d/ssl.conf.bk

cat > /etc/httpd/conf.d/ssl.conf.tmp <<EOF
<VirtualHost *:443>
    ServerName localhost:443
    ServerAlias localhost
    ServerAdmin admin@breaktech.com
    # SSL directives
    SSLEngine on
    SSLCertificateFile      "/etc/pki/tls/certs/defaultSSL.crt"
    SSLCertificateKeyFile   "/etc/pki/tls/private/defaultSSL.key"
    SSLCACertificatePath    "/etc/pki/tls/certs"
    # Uncomment the following line to force Apache to pass the Authorization
    # header to PHP: required for "basic_auth" under PHP-FPM and FastCGI
    #
    # SetEnvIfNoCase ^Authorization$ "(.+)" HTTP_AUTHORIZATION=\$1
    # For Apache 2.4.9 or higher
    # Using SetHandler avoids issues with using ProxyPassMatch in combination
    # with mod_rewrite or mod_autoindex
    DocumentRoot /var/www/html
    <Directory /var/www/html>
        # Disable directory index
        Options Indexes FollowSymLinks
        # enable the .htaccess rewrites
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
    ErrorLog "/var/log/httpd/localhost_ssl-error_log"
    CustomLog "/var/log/httpd/localhost_ssl-access_log" common
</VirtualHost>
EOF
