#!/bin/sh

# wait for rpcbind
sv start rpcbind || exit 1

# wait for idmapd
sv start idmapd || exit 1


/usr/sbin/rpc.nfsd --syslog
/usr/sbin/exportfs -r
exec /usr/sbin/rpc.mountd -F
