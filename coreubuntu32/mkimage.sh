#!/bin/bash
set -e

isrootuser(){
	if ! [ $(id -u) = 0 ]; then
		echo "This script must be run as root" 1>&2
		exit 1
	fi
}


isrootuser

cd /tmp

sudo debootstrap --arch i386 saucy saucy

sudo tar -C saucy -c . | docker import - bySabi/coreubuntu32

exit
