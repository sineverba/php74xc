build:
		docker build --tag sineverba/testphp74xc .

test:
		@docker run --rm sineverba/testphp74xc php -v | grep 7.4.7
		@docker run --rm sineverba/testphp74xc php -m | grep xdebug
		@docker run --rm sineverba/testphp74xc /usr/bin/composer -V | grep Composer
		@docker run --rm sineverba/testphp74xc php -i | grep "short_open_tag => Off => Off"
		@docker run --rm sineverba/testphp74xc php -i | grep "memory_limit => 512M => 512M"

destroy:
		docker image rm sineverba/testphp74xc