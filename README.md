php74xc: Docker image for PHP7.4 + Xdebug + Composer
====================================================

Docker image built from **PHP7.4** CLI official + **X**debug + **C**omposer

## Add image as alias

``` bash

$ cd ~
$ nano .bashrc
$ alias php74='docker run -it -w /data -v ${PWD}:/data --entrypoint php --rm php74xc:1.0.0'
$ alias composer74='docker run -it -w /data -v ${PWD}:/data --entrypoint "/usr/bin/composer" --rm php74xc:1.0.0'

```

### Build and test image

+ Check images list

`$ docker image ls`

+ Clone the project

`$ git clone git@github.com:sineverba/php74xc.git`

+ Run from same folder

`$ docker build --tag php74xc:1.0.0 .`

+ Check new image (php74xc:1.0.0)

`$ docker image ls`