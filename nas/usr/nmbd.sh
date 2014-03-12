#!/bin/sh

# wait for smbd start
sv start smbd || exit 1

exec /usr/sbin/nmbd -F
