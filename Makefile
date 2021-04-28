build:
		docker build --tag sineverba/testphp74xc .

multiple:
		docker buildx build --tag sineverba/testphp74xc --platform linux/386,linux/amd64,linux/arm/v6,linux/arm/v7 --push .

test:
		@docker run --rm sineverba/testphp74xc php -v | grep 7.4.16
		@docker run --rm sineverba/testphp74xc php -v | grep OPcache
		@docker run --rm sineverba/testphp74xc php -m | grep xdebug
		@docker run --rm sineverba/testphp74xc php -r "xdebug_info();" | grep "3.0.4"
		@docker run --rm sineverba/testphp74xc php -m | grep pdo_pgsql
		@docker run --rm sineverba/testphp74xc php -m | grep zip
		@docker run --rm sineverba/testphp74xc /usr/bin/composer -V | grep "1.10.22"
		@docker run --rm sineverba/testphp74xc php -i | grep "short_open_tag => Off => Off"
		@docker run --rm sineverba/testphp74xc php -i | grep "memory_limit => 512M => 512M"

destroy:
		docker image rm sineverba/testphp74xc