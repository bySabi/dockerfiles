#!/bin/sh

# wait for dbus start
sv start dbus || exit 1

exec /usr/sbin/avahi-daemon
