#!/bin/sh

exec /usr/bin/mysqld_safe --defaults-file=/srv/conf.d/mariadb/my.cnf --syslog
