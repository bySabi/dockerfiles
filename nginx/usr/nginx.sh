#!/bin/sh

# wait for php5-fpm start
sv start php5-fpm || exit 1

exec nginx
