#!/bin/bash


echo "root:$PASSWORD" |chpasswd


if [ ! -d "$DATADIR/samba/private" ]; then
	mkdir -p "$DATADIR/samba/private"
fi


#if BRIDGED wait for interface up
[ "$BRIDGED" ] && {
	pipework --wait
}

service samba4 start


#not exit from script. Needed on docker
# Send SIGSTOP to itself
kill -STOP "$$";
