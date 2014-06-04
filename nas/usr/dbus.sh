#!/bin/sh
set +e

rm /var/run/dbus/pid
exec /bin/dbus-daemon --system --nofork
