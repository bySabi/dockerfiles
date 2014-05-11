#!/bin/sh

# wait for rpcbind
sv start nfsd || exit 1

exec /usr/sbin/rpc.idmapd -f -c /srv/conf.d/nfs/idmapd.conf
