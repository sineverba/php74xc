IMAGE_NAME=sineverba/php74xc
CONTAINER_NAME=php74xc
APP_VERSION=1.8.0-dev
BUILDX_VERSION=0.10.0
BINFMT_VERSION=qemu-v7.0.0-28

build:
	docker build --tag $(IMAGE_NAME):$(APP_VERSION) .

preparemulti:
	mkdir -vp ~/.docker/cli-plugins
	curl -L "https://github.com/docker/buildx/releases/download/v$(BUILDX_VERSION)/buildx-v$(BUILDX_VERSION).linux-amd64" > ~/.docker/cli-plugins/docker-buildx
	chmod a+x ~/.docker/cli-plugins/docker-buildx
	docker buildx version
	docker run --rm --privileged tonistiigi/binfmt:$(BINFMT_VERSION) --install all
	docker buildx ls
	docker buildx rm multiarch
	docker buildx create --name multiarch --driver docker-container --use
	
multi:
	docker buildx inspect --bootstrap --builder multiarch
	docker buildx build --platform linux/arm64/v8,linux/amd64,linux/arm/v6,linux/arm/v7 --tag $(IMAGE_NAME):$(APP_VERSION) --tag $(IMAGE_NAME):latest .

test:
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) php -v | grep 7.4.33
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) php -v | grep OPcache
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) php -m | grep xdebug
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) php -r "xdebug_info();" | grep "3.1.5"
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) php -m | grep pdo_pgsql
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) php -m | grep zip
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) php -m | grep mcrypt
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) /usr/bin/composer -V | grep "1.10.26"
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) php -i | grep "short_open_tag => Off => Off"
	@docker run --name $(CONTAINER_NAME) --rm $(IMAGE_NAME):$(APP_VERSION) php -i | grep "memory_limit => 512M => 512M"

destroy:
	docker image rm $(IMAGE_NAME):$(APP_VERSION)