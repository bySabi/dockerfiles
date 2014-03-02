#!/bin/bash


echo "root:$PASSWORD" |chpasswd


#if BRIDGED wait for interface up
[ "$BRIDGED" ] && {
	pipework --wait
}

service avahi-daemon start
service netatalk start


#not exit from script. Needed on docker
# Send SIGSTOP to itself
kill -STOP "$$";
