IMAGE_NAME=sineverba/testphp74xc
CONTAINER_NAME=testphp74xc

build:
		docker build --tag $(IMAGE_NAME) .

multiple:
		docker buildx build --tag $(IMAGE_NAME) --platform linux/386,linux/amd64,linux/arm/v6,linux/arm/v7 --push .

test:
		@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME) php -v | grep 7.4.28
		@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME) php -v | grep OPcache
		@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME) php -m | grep xdebug
		@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME) php -r "xdebug_info();" | grep "3.1.3"
		@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME) php -m | grep pdo_pgsql
		@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME) php -m | grep zip
		@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME) /usr/bin/composer -V | grep "1.10.25"
		@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME) php -i | grep "short_open_tag => Off => Off"
		@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME) php -i | grep "memory_limit => 512M => 512M"

destroy:
		docker image rm $(IMAGE_NAME)