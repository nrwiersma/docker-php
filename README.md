![Logo](http://svg.wiersma.co.za/github/project?lang=docker&title=php)

[![Docker Build Statu](https://img.shields.io/docker/build/nrwiersma/php.svg)](https://hub.docker.com/r/nrwiersma/php/)
[![Docker Pulls](https://img.shields.io/docker/pulls/nrwiersma/php.svg)](https://hub.docker.com/r/nrwiersma/php/)

## Base Image

When using this as a base image, it is advised that you switch to user *nobody*.

## Configuration

Configuration can be done with environment variables.

| Environment Variable | Description | Default |
| -------------------- | ----------- | ------- |
| PHP_WORKERS | The number of php-fpm workers to start | 2
| PHP_MEMORY_LIMIT | The PHP memory limit | 128M
| PHP_MAX_FILE_UPLOADS | The maximum number of files allowed to be upload simultaneously | 20
| PHP_MAX_UPLOAD | The maximum size of an uploaded file | 50M
| PHP_MAX_POST | The maxumum size of POST data allowed | 50M 
