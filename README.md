php74xc: Docker image for PHP7.4.x + Xdebug + Composer
======================================================

| CD / CI   |           |
| --------- | --------- |
| Travis CI | [![Build Status](https://travis-ci.com/sineverba/php74xc.svg?branch=master)](https://travis-ci.com/sineverba/php74xc) |



Docker image built from **PHP7.4.x** CLI official + **X**debug + **C**omposer.

Short tags are __OFF__.

Image ready to use as alias for development.

Do you use it? **Star it!**

## Add image as alias

``` bash

$ cd ~
$ nano .bashrc
$ alias php74='docker run -it -w /data -v ${PWD}:/data --entrypoint php --rm sineverba/php74xc:latest'
$ alias composer74='docker run -it -w /data -v ${PWD}:/data --entrypoint "/usr/bin/composer" --rm sineverba/php74xc:latest'

```

### Build and test image locally

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