#!/usr/bin/env bash

cat > /tmp/openssl.cnf <<EOF
#-------------openssl.cnf----------------
[ req ]
default_bits                        = 1024 # Size of keys
default_keyfile                     = key.pem # name of generated keys
default_md                          = md5 # message digest algorithm
string_mask                         = nombstr # permitted characters
distinguished_name                  = req_distinguished_name

[ req_distinguished_name ]
# Variable name   Prompt string
0.organizationName                  = ORGANIZATION_NAME
organizationalUnitName              = ORGANIZATIONAL_UNIT_NAME
emailAddress                        = EMAIL_ADDRESS
emailAddress_max                    = 40
localityName                        = LOCALITY_NAME
stateOrProvinceName                 = STATE
countryName                         = COUNTRY_NAME
countryName_min                     = 2
countryName_max                     = 2
commonName                          = COMMON_NAME
commonName_max                      = 64

# Default values for the above, for consistency and less typing.
countryName_default                 = US
stateOrProvinceName_default         = IL
localityName_default                = Evanston
0.organizationName_default          = My Organization
organizationalUnitName_default      = Development
commonName_default                  = *@mine.org
emailAddress_default                = me@mine.com
EOF

sed -i -e "s|ORGANIZATION_NAME|$SSL_ORGANIZATION_NAME|" \
       -e "s|ORGANIZATIONAL_UNIT_NAME|$SSL_ORGANIZATIONAL_UNIT_NAME|" \
       -e "s|EMAIL_ADDRESS|$SSL_EMAIL_ADDRESS|" \
       -e "s|LOCALITY_NAME|$SSL_LOCALITY_NAME|" \
       -e "s|STATE|$SSL_STATE|" \
       -e "s|COUNTRY_NAME|$SSL_COUNTRY_NAME|" \
       -e "s|COMMON_NAME|$SSL_COMMON_NAME|" \
       /tmp/openssl.cnf

