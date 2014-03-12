#!/bin/sh

[ "$DATADIR" ] && {
	[ -d "$DATADIR/samba/private" ] || mkdir -p "$DATADIR/samba/private"
}

/etc/init.d/sernet-samba-smbd start
/etc/init.d/sernet-samba-nmbd start
