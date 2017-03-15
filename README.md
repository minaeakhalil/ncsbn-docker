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
2. Get your copy of TAO
3. `cp .env.default .env`
4. Edit the newly created `.env` appropriately. Please go [here for more info](#setting-your-environment-file)
5. Build your docker containers run `docker-compose build`
6. Run your docker containers run `docker-compose up -d`
7. Verify that you have 2 containers running `docker-compose ps`

## Setting your Environment File
| Parameter | Description | Sample |
| --------- | ----------- | ------ |
| MYSQL_ROOT_PASSWORD | A password for the Root User | test123 |
| MYSQL_PORT | Port for MySQL | 3306 |
| MYSQL_HOST_DATA_DIR | local dir (on host machine) to store the data | /path/to/your/local-repo/mysql/data |
| MYSQL_GUEST_DATA_DIR | a mapped dir on the guest machine to store the data | /var/lib/mysql |
| HTTP_PORT | Mapped port for HTTP on host machine | 8080 |
| HOSTNAME | Application desired hostname | tao-docker |
| TIMEZONE | Guest machine timezone | UTC |
| TAO_HOST_DIR | Location of the TAO code on host machine | /path/to/your/local-repo/server/code/tao |
| TAO_GUEST_DIR | Mapped location of TAO code on the guest machine | /var/www/html |
