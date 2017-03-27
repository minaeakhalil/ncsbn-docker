FROM centos:6.8

# -----------------------------------------------------------------------------
# Base Install + Import the RPM GPG keys for Repositories
# -----------------------------------------------------------------------------
RUN rpm --rebuilddb \
    && rpm --import \
        http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-6 \
    && rpm --import \
        https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6 \
    && rpm --import \
        https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY \
    && yum -y install \
        centos-release-scl \
        centos-release-scl-rh \
        epel-release \
        https://centos6.iuscommunity.org/ius-release.rpm \
        vim-minimal-7.4.629-5.el6_8.1 \
        xz-4.999.9-0.5.beta.20091007git.el6.x86_64 \
        sudo-1.8.6p3-25.el6_8 \
        openssh-5.3p1-118.1.el6_8 \
        openssh-server-5.3p1-118.1.el6_8 \
        openssh-clients-5.3p1-118.1.el6_8 \
        python-setuptools-0.6.10-3.el6 \
        yum-plugin-versionlock-1.1.30-37.el6 \
        libxml2-2.7.6-21.el6_8.1 \
        openssl-1.0.1e-48.el6_8.3 \
    && yum versionlock add \
        vim-minimal \
        xz \
        sudo \
        openssh \
        openssh-server \
        openssh-clients \
        python-setuptools \
        yum-plugin-versionlock \
    && yum clean all \
    && find /usr/share \
        -type f \
        -regextype posix-extended \
        -regex '.*\.(jpg|png)$' \
        -delete \
    && rm -rf /etc/ld.so.cache \
    && rm -rf /sbin/sln \
    && rm -rf /usr/{{lib,share}/locale,share/{man,doc,info,cracklib,i18n},{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive} \
    && rm -rf /{root,tmp,var/cache/{ldconfig,yum}}/* \
    && > /etc/sysconfig/i18n

# -----------------------------------------------------------------------------
# UTC Timezone & Networking
# -----------------------------------------------------------------------------
RUN ln -sf \
        /usr/share/zoneinfo/UTC \
        /etc/localtime \
    && echo "NETWORKING=yes" > /etc/sysconfig/network

# -----------------------------------------------------------------------------
# Necessary packages
#   1. ntp
#   2. Aapche
#   3. Apache SSL Module
#   4. OpenSSL
# -----------------------------------------------------------------------------
RUN yum -y install ntp \
    httpd \
    mod_ssl \
    openssl \
    && service httpd stop \
    && service ntpd start

# -----------------------------------------------------------------------------
# Apache Configuration
#   1. Disable unused modules
#   2. Disable Server Tokens
#   3. Disable Server Signature
#   4. Set server admin email
#   5. Enable Virtual Host on port 80
# -----------------------------------------------------------------------------
ARG HOSTNAME

ADD ./conf/apache/apache.sh /apache.sh

#RUN chmod +x /apache.sh \
#    &&
RUN ./apache.sh \
    && sed -i -e 's/ServerTokens OS/ServerTokens Prod/g' \
        -e 's/ServerSignature On/ServerSignature Off/g' \
        -e "s/ServerAdmin root@localhost/ServerAdmin admin@${HOSTNAME}/g" \
        -e "s/#NameVirtualHost/NameVirtualHost/" \
        -e 's/LoadModule auth_basic_module/#LoadModule auth_basic_module/g' \
        -e 's/LoadModule auth_digest_module/#LoadModule auth_digest_module/g' \
        -e 's/LoadModule authn_file_module/#LoadModule authn_file_module/g' \
        -e 's/LoadModule authn_alias_module/#LoadModule authn_alias_module/g' \
        -e 's/LoadModule authn_anon_module/#LoadModule authn_anon_module/g' \
        -e 's/LoadModule authn_dbm_module/#LoadModule authn_dbm_module/g' \
        -e 's/LoadModule authn_default_module/#LoadModule authn_default_module/g' \
        -e 's/LoadModule authz_user_module/#LoadModule authz_user_module/g' \
        -e 's/LoadModule authz_owner_module/#LoadModule authz_owner_module/g' \
        -e 's/LoadModule authz_groupfile_module/#LoadModule authz_groupfile_module/g' \
        -e 's/LoadModule authz_dbm_module/#LoadModule authz_dbm_module/g' \
        -e 's/LoadModule authz_default_module/#LoadModule authz_default_module/g' \
        -e 's/LoadModule ldap_module/#LoadModule ldap_module/g' \
        -e 's/LoadModule authnz_ldap_module/#LoadModule authnz_ldap_module/g' \
        -e 's/LoadModule include_module/#LoadModule include_module/g' \
        -e 's/LoadModule logio_module/#LoadModule logio_module/g' \
        -e 's/LoadModule ext_filter_module/#LoadModule ext_filter_module/g' \
        -e 's/LoadModule mime_magic_module/#LoadModule mime_magic_module/g' \
        -e 's/LoadModule expires_module/#LoadModule expires_module/g' \
        -e 's/LoadModule usertrack_module/#LoadModule usertrack_module/g' \
        -e 's/LoadModule dav_module/#LoadModule dav_module/g' \
        -e 's/LoadModule status_module/#LoadModule status_module/g' \
        -e 's/LoadModule info_module/#LoadModule info_module/g' \
        -e 's/LoadModule dav_fs_module/#LoadModule dav_fs_module/g' \
        -e 's/LoadModule vhost_alias_module/#LoadModule vhost_alias_module/g' \
        -e 's/LoadModule actions_module/#LoadModule actions_module/g' \
        -e 's/LoadModule speling_module/#LoadModule speling_module/g' \
        -e 's/LoadModule userdir_module/#LoadModule userdir_module/g' \
        -e 's/LoadModule substitute_module/#LoadModule substitute_module/g' \
        -e 's/LoadModule proxy_module/#LoadModule proxy_module/g' \
        -e 's/LoadModule proxy_balancer_module/#LoadModule proxy_balancer_module/g' \
        -e 's/LoadModule proxy_ftp_module/#LoadModule proxy_ftp_module/g' \
        -e 's/LoadModule proxy_http_module/#LoadModule proxy_http_module/g' \
        -e 's/LoadModule proxy_ajp_module/#LoadModule proxy_ajp_module/g' \
        -e 's/LoadModule proxy_connect_module/#LoadModule proxy_connect_module/g' \
        -e 's/LoadModule cache_module/#LoadModule cache_module/g' \
        -e 's/LoadModule suexec_module/#LoadModule suexec_module/g' \
        -e 's/LoadModule disk_cache_module/#LoadModule disk_cache_module/g' \
        -e 's/LoadModule cgi_module/#LoadModule cgi_module/g' \
        -e 's/LoadModule version_module/#LoadModule version_module/g' \
        /etc/httpd/conf/httpd.conf

# -----------------------------------------------------------------------------
# Install and Configure SSL Certificate
# -----------------------------------------------------------------------------
ARG SSL_ORGANIZATION_NAME
ARG SSL_ORGANIZATIONAL_UNIT_NAME
ARG SSL_EMAIL_ADDRESS
ARG SSL_LOCALITY_NAME
ARG SSL_STATE
ARG SSL_COUNTRY_NAME
ARG SSL_COMMON_NAME

ADD ./conf/SSL/openssl.sh /openssl.sh

RUN openssl genrsa -out defaultSSL.key 1024 
RUN chmod +x /openssl.sh 
RUN ./openssl.sh \
    && openssl req -new -key defaultSSL.key -out defaultSSL.csr -config /tmp/openssl.cnf -batch \
    && openssl x509 -req -days 3650 -in defaultSSL.csr -signkey defaultSSL.key -out defaultSSL.crt \
    && cp defaultSSL.crt /etc/pki/tls/certs \
    && cp defaultSSL.key /etc/pki/tls/private \
    && rm -f openssl.cnf defaultSSL.crt defaultSSL.key defaultSSL.csr

# -----------------------------------------------------------------------------
# Further Apache Configuration
#   1. Enable .htaccess in the default DocRoot
#   2. Enable GZIP compression on Apache
#   3. Configure default servername
#   4. Hide Apache signature for security reasons
#   5. Setup publicly available Administrator's email address
#   6. Enable Virtual Host required for SSL
#   7. Enable SSL Virtual Host to listen on port 443
# -----------------------------------------------------------------------------
#RUN sed -i -e 'N;s/#\n    AllowOverride None/#\n    AllowOverride All/g' \
#        -e '$a\\n#\n# Enable GZIP compression\n#\n<IfModule mod_deflate.c>\n    SetOutputFilter DEFLATE\n    AddOutputFilterByType DEFLATE application/atom+xml application/font-woff application/javascript application/json application/rss+xml application/vnd.ms-fontobject application/x-font application/x-font-opentype application/x-font-otf application/x-font-truetype application/x-font-ttf application/x-font-woff application/x-httpd-php application/x-javascript application/xhtml+xml application/xml font/opentype font/otf font/ttf image/svg+xml image/x-icon text/css text/csv text/html text/javascript text/plain text/xml\n    BrowserMatch ^Mozilla/4 gzip-only-text/html\n    BrowserMatch ^Mozilla/4\.0[678] no-gzip\n    BrowserMatch \bMSIE !no-gzip !gzip-only-text/html\n    BrowserMatch \bMSI[E] !no-gzip !gzip-only-text/html\n    SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png)$ no-gzip\n    Header append Vary User-Agent env=!dont-vary\n</IfModule>' \
#        -e '$a\\nServerName localhost:80' \
#        /etc/httpd/conf/httpd.conf \
#    && sed -i -e "s/Listen 443/Listen 443\nNameVirtualHost *:443/" /etc/httpd/conf.d/ssl.conf

EXPOSE 80

# -----------------------------------------------------------------------------
# SSL Localhost Configuration
# -----------------------------------------------------------------------------
RUN sed -i -e 's|SSLCertificateFile /etc/pki/tls/certs/localhost.crt|SSLCertificateFile /etc/pki/tls/certs/defaultSSL.crt|g' \
           -e 's|SSLCertificateKeyFile /etc/pki/tls/private/localhost.key|SSLCertificateKeyFile /etc/pki/tls/private/defaultSSL.key|g' \
           /etc/httpd/conf.d/ssl.conf

EXPOSE 443

# -----------------------------------------------------------------------------
# Install SupervisorD
# -----------------------------------------------------------------------------
RUN easy_install \
        'supervisor == 3.3.1' \
        'supervisor-stdout == 0.1.1' \
    && echo_supervisord_conf > /etc/supervisord.conf \
    && mkdir /etc/supervisor.d/ \
    && mkdir -p /var/log/supervisor/ \
    && sed -i -e "s|;\[include\]|\[include\]|g" \
        -e "s|;files \= relative\/directory\/\*.ini|files \= \/etc\/supervisor.d\/\*conf|g" \
        /etc/supervisord.conf

# -----------------------------------------------------------------------------
# Configure Supervisord to run Apache
# -----------------------------------------------------------------------------
COPY ./conf/supervisord/httpd.conf /etc/supervisor.d/

# -----------------------------------------------------------------------------
# Configure SSH 
# -----------------------------------------------------------------------------
ADD ./conf/ssh/set_root_pw.sh \
    /set_root_pw.sh
ADD ./conf/ssh/id_docker_root_rsa.pub \
    /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

RUN yum -y install pwgen
RUN rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
RUN sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

# -----------------------------------------------------------------------------
# Install PHP
# -----------------------------------------------------------------------------
#RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm 
RUN  yum -y install yum-utils 
RUN  yum-config-manager --enable remi remi-php56 
RUN  yum remove -y yum-utils 
#RUN  yum --enablerepo=remi install -y php 
RUN  yum install -y php56u
RUN  yum install -y  php56u-mysqlnd
RUN  yum install -y  php56u-opcache 
RUN  yum install -y  php56u-mbstring 
RUN  yum install -y  php56u-xml

#RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm \
#    && yum -y install yum-utils \
#    && yum-config-manager --enable remi remi-php56 \
#    && yum remove -y yum-utils \
#    && yum --enablerepo=remi install -y php \
#        php-mysqlnd \
#        php-opcache \
#        php-mbstring \
#        php-xml

# -----------------------------------------------------------------------------
# Configure PHP
# -----------------------------------------------------------------------------
RUN sed -i -e "s/;date.timezone =/date.timezone = ${TIMEZONE}/g" \
        -e 's/short_open_tag = Off/short_open_tag = On/g' \
        -e 's/expose_php = On/expose_php = Off/g' \
        -e 's/mail.add_x_header = On/mail.add_x_header = Off/g' \
        -e 's/session.use_strict_mode = 0/session.use_strict_mode = 1/g' \
        /etc/php.ini

# -----------------------------------------------------------------------------
# Install Composer. Composer hash code would change with every version update
# -----------------------------------------------------------------------------
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

                                                                               
# -----------------------------------------------------------------------------    
# Install GIT so composer runs                                                 
# -----------------------------------------------------------------------------
RUN yum -y install git

# -----------------------------------------------------------------------------
# Copy the content of Tao to the DocRoot
# -----------------------------------------------------------------------------
ADD ./code/tao /var/www/html

# -----------------------------------------------------------------------------
# Add run.sh as an ENTRYPOINT. This would do:
#   1. Runs Composer install to get Tao components
#   2. Install Tao 3.1 RC7
#   3. Starts supervisord
# -----------------------------------------------------------------------------
ADD run.sh /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
