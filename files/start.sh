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
/usr/sbin/php-fpm7 &

# Start Nginx
/usr/sbin/nginx -g "daemon off;" &

# Now wait for them to finish
wait
