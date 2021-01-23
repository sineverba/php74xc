php74xc: Docker image for PHP7.4.x + Xdebug + Composer
======================================================

| CD / CI   |           |
| --------- | --------- |
| Travis CI | [![Build Status](https://travis-ci.com/sineverba/php74xc.svg?branch=master)](https://travis-ci.com/sineverba/php74xc) |



Docker image built from **PHP7.4.x** CLI official + **X**debug + **C**omposer.

Short tags are __OFF__.

Image ready to use as alias for development.

Do you use it? **Star it!**



## Versions

| Component | Version |
| --------- | ------- |
| PHP | 7.4.14 |
| Composer | 1.10.19 |


## Github / image tags vs PHP version

Q: Why release / version number bumped from 1.x to 7.x?
A: Cause I'm following PHP releases version.

| Github / Docker Image tag | PHP Version | Composer version |
| ------------------ | ----------- | ---------------- |
| latest | 7.4.14 | 1.10.19 |
| 7.4.14 | 7.4.14 | 1.10.19 |
| 7.4.13-2 | 7.4.13 | 1.10.17 |
| 7.4.13-1 | 7.4.13 | 1.10.17 |
| 7.4.13 | 7.4.13 | 1.10.17 |
| 7.4.12 | 7.4.12 | 1.10.17 |
| 7.4.11 | 7.4.11 | 1.10.13 |
| 1.5.0 | 7.4.9 | 1.10.10 |

## Xdebug and settings

During development, you can enable/disable xdebug.mode` with

```yaml
# docker-compose.yml
services:
  app:
    environment:
      XDEBUG_MODE: "off"
```

For values, see [https://xdebug.org/docs/all_settings#mode](https://xdebug.org/docs/all_settings#mode)

## OpCache and settings

During development, you can enable/disable `opcache_validate_timestamps` with

```yaml
# docker-compose.yml
services:
  app:
    environment:
      PHP_OPCACHE_VALIDATE_TIMESTAMPS: 1
```

### Update local image

`$ docker pull sineverba/php74xc:latest`


### PHP modules

`$ docker run --rm sineverba/php74xc php -m`

| PHP modules |
| ----------- |
| bcmath |
| Core |
| ctype |
| curl |
| date |
| dom |
| exif |
| fileinfo |
| filter |
| ftp |
| gd |
| hash |
| iconv |
| json |
| libxml |
| mbstring |
| mysqli |
| mysqlnd |
| openssl |
| pcntl |
| pcre |
| PDO |
| pdo_mysql |
| pdo_pgsql |
| pdo_sqlite |
| Phar |
| posix |
| readline |
| Reflection |
| session |
| SimpleXML |
| sodium |
| SPL |
| sqlite3 |
| standard |
| tokenizer |
| xdebug |
| xml |
| xmlreader |
| xmlreader |
| xmlwriter 
| xmlreader |
| zlib |
| Xdebug |
| zip |

### Add image as alias

``` bash
$ cd ~
$ nano .bashrc
$ alias php74='docker run -it -w /data -v ${PWD}:/data --entrypoint php --rm sineverba/php74xc:latest'
$ alias composer74='docker run -it -w /data -v ${PWD}:/data --entrypoint "/usr/bin/composer" --rm sineverba/php74xc:latest'
```

### Issues with memory limit (on composer)

`$ php -d memory_limit=-1 /usr/bin/composer require [...]`

#### Build and test image locally

```shell
$ make build
$ make test
$ make destroy
```

+ Check images list

`$ docker image ls`

+ Clone the project

`$ git clone git@github.com:sineverba/php74xc.git`

+ Run from same folder

`$ docker build --tag php74xc:x.y.z .`

+ Check new image (php74xc:x.y.z)

`$ docker image ls`