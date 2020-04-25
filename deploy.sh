#!/bin/sh

echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin;

docker push $DOCKER_USERNAME/$DOCKER_IMAGE;

docker rmi $DOCKER_USERNAME/$DOCKER_IMAGE;