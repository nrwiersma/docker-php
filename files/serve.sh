#!/bin/sh

set -e

killAll()
{
  pkill -P $$
}

# call function to kill all children on SIGCHLD from the first one
trap killAll SIGCHLD
trap killAll SIGTERM

# Start PHP-FPM
/usr/sbin/php-fpm7 \
	-d memory_limit=$PHP_MEMORY_LIMIT \
	-d upload_max_filesize=$MAX_UPLOAD \
	-d max_file_uploads=$PHP_MAX_FILE_UPLOADS \
	-d post_max_size=$PHP_MAX_POST &

# Start Nginx
/usr/sbin/nginx -g "daemon off;" &

# Now wait for them to finish
wait
