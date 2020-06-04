#!/bin/sh
set -e
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE php -v | grep 7.4.6
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE php -m | grep xdebug
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE /usr/bin/composer -V | grep Composer
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE php -i | grep "short_open_tag => Off => Off"
docker run --rm $DOCKER_USERNAME/$DOCKER_IMAGE php -i | grep "memory_limit => 256M => 256M"