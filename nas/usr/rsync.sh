#!/bin/sh
set -e

exec tcpsvd -v 0 873 /usr/bin/rsync --daemon --no-detach --config=/srv/conf.d/rsyncd/rsyncd.conf
