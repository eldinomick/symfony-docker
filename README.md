Image Fork from excellent ![Build status](https://github.com/recognizebv/symfony-docker/workflows/Build/badge.svg)


# compilation
- a script build-dev.sh for compilation developpement version
- a other for production

## Docker-compose
```
version: '3'
services:
    CE:
        image: cadotinfo/nsymfony-dev:latest or cadotinfo/nsymfony-prod:latest
        container_name: CE
        volumes:
            - .:/app/
        networks:
            - web
        restart: always
        ports:
            - 49800:80
networks:
    web:
        external: true
```

## Available variants
- php7.1 - php8 (PHP Version)
- -node10, -node-12, -node-14 (Node LTS versions)
- -image (vips and imagick)
- -dev (XDebug)

[List of tags per php version](https://github.com/RecognizeBV/symfony-docker/releases)
[All tags](https://hub.docker.com/r/recognizebv/symfony-docker/tags)

## What's here?

This repository is a source code for following docker images that allow relatively easily work with symfony php framework.

### Adjust your symfony app kernel to write cache and logs to /tmp dir
```
    public function getCacheDir()
    {
        return sys_get_temp_dir().'/cache/'.$this->getEnvironment();
    }

    public function getLogDir()
    {
        return sys_get_temp_dir().'/logs/'.$this->getEnvironment();
    }
```

### Output logs to stderr (optional)

You may want to adjust config_dev and config_prod to output logs to stderr (so they will be handled correctly by docker)
``
path:  "php://stderr"
``

# Build production image

You can build production ready image with dockerfile like this:

```
FROM recognizebv/symfony-docker:php7.1
ADD . /var/www/html
# Add your application build steps here, for example:
# RUN ./var/www/html/web/bin/...
RUN rm -rf /var/www/html/web/app_dev.php
RUN rm -rf /var/www/html/web/config.php
```

# FAQ

## What are extensions enabled by default?
* apache mod_rewrite
* intl
* opcache
* pdo
* pdo_mysql
* pdo_pgsql
* zip
* gd
* xdebug (only in dev images)

## How do i install additional php extensions?
This work is based on official dockerhub php images. You can use docker-php-ext-install to add new extensions. More informations can be found https://hub.docker.com/_/php/

## Why can't i access app_dev.php?
By default symfony block requests to app_dev.php that come from non localhost sources. You can change that editing app_dev.php file.
