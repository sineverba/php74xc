#!/bin/sh
set -e
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE php -v | grep 7.4.11
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE php -m | grep xdebug
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE php -m | grep pdo_pgsql
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE /usr/bin/composer -V | grep "1.10.13"
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE php -i | grep "short_open_tag => Off => Off"
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE php -i | grep "memory_limit => 512M => 512M"