# NCSBN TAO Docker Container
Please refer to this [confluence page](https://breaktech.atlassian.net/wiki/display/NCSBN/TAO+Docker+Set+Special+Project)
for more details about this project.

## Table of Contents
- [Pre-requisites](#pre-requisites)
- [Installation](#installation)
- [Setting your Environment File](#setting-your-environment-file)

## Pre-requisites
- Get copy of TAO from [here as ZIP](http://releases.taotesting.com/TAO_3.1.0-RC7_build.zip) or
[clone it from Github and checkout tag "v3.1-rc07"](https://github.com/oat-sa/package-tao)
- Docker should be installed either Natively (not recommended for Windows machines) or through VM. Feel free to use the
[VM from this project](https://github.com/minaeakhalil/docker).
```bash
$ docker --version

Docker version 17.03.0-ce, build 60ccb22
```
- Docker compose is installed as well. To verify the version
```bash
$ docker-compose --version

docker-compose version 1.11.2, build dfed245
```

## Installation
1. Clone this repo
2. Get your copy of TAO and put under `/path/to/this/repo/server/code/tao`
3. `cp .env.default .env`
4. Edit the newly created `.env` appropriately. Please go [here for more info](#setting-your-environment-file)
5. Build your docker containers run `docker-compose build`
6. Run your docker containers run `docker-compose up -d`
7. Verify that you have 2 containers running
```bash
$ docker-compose ps

 Name              Command             State            Ports          
----------------------------------------------------------------------
mysql    docker-entrypoint.sh mysqld   Up      0.0.0.0:33306->3306/tcp 
server   /run.sh                       Up      0.0.0.0:8080->80/tcp   
```

## Setting your Environment File
| Parameter | Description | Sample |
| --------- | ----------- | ------ |
| MYSQL_ROOT_PASSWORD | A password for the Root User | test123 |
| MYSQL_PORT | Port for MySQL | 3306 |
| MYSQL_HOST_DATA_DIR | local dir (on host machine) to store the data | /path/to/your/local-repo/mysql/data |
| MYSQL_GUEST_DATA_DIR | a mapped dir on the guest machine to store the data | /var/lib/mysql |
| HTTP_PORT | Mapped port for HTTP on host machine | 8080 |
| HTTPS_PORT | Mapped port for HTTPS on host machine | 4443 |
| HOSTNAME | Application desired hostname | tao-docker |
| TIMEZONE | Guest machine timezone | UTC |
| TAO_HOST_DIR | Location of the TAO code on host machine | /path/to/your/local-repo/server/code/tao |
| TAO_GUEST_DIR | Mapped location of TAO code on the guest machine | /var/www/html |
| SSL_ORGANIZATION_NAME | Organization Name | Breakthrough Technologies LLC |
| SSL_ORGANIZATIONAL_UNIT_NAME | Department | Developement |
| SSL_EMAIL_ADDRESS | An email address | first.last@breaktech.com |
| SSL_LOCALITY_NAME | City | Evanston |
| SSL_STATE | State | IL |
| SSL_COUNTRY_NAME | Country | US |
| SSL_COMMON_NAME | Common Name | *@breaktech.com* |
| ROOT_PASSWORD | SSH Root Password | |

