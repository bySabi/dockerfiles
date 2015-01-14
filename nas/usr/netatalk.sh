#!/bin/sh

# wait for avahi-daemon
sv start avahi || exit 1

# run on debug mode to state on foreground
#exec /usr/sbin/netatalk -d
exec netatalk -d