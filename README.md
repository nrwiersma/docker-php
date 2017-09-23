![Logo](http://svg.wiersma.co.za/github/project?lang=docker&title=php)

A lightweight Docker container entangling php-fpm and nginx.

## Configuration

Configuration can be done with environment variables.

| Environment Variable | Description | Default |
| -------------------- | ----------- | ------- |
| PHP_WORKERS | The number of php-fpm workers to start | 2
| PHP_MEMORY_LIMIT | The PHP memory limit | 128M
| PHP_MAX_FILE_UPLOADS | The maximum number of files allowed to be upload simultaneously | 20
| PHP_MAX_UPLOAD | The maximum size of an uploaded file | 50M
| PHP_MAX_POST | The maxumum size of POST data allowed | 50M 