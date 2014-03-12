#!/bin/sh

[ "$CONFDIR" ] && {
	[ -d "$CONFDIR/samba/private" ] || mkdir -p "$CONFDIR/samba/private"
}

exec /usr/sbin/smbd -F
