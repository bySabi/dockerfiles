#!/bin/sh


[ "$DATADIR" ] && {
	[ -f "$DATADIR/.deployed" ] || {
		[ -d "$DATADIR/www" ] && chown -R www-data "$DATADIR/www"
		touch "$DATADIR/.deployed"
	}
}

/etc/init.d/nginx start
