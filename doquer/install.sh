#!/bin/bash
set -e

INSTALLDIR=/usr/local/bin
DATADIR=/var/lib/doquer

isrootuser(){
	if ! [ $(id -u) = 0 ]; then
		echo "This script must be run as root" 1>&2
		exit 1
	fi
}

isrootuser

install -o root -m 755 doquer $INSTALLDIR
install -o root -m 644 bash_completion/doquer /etc/bash_completion.d/

mkdir -p $DATADIR
chmod -R 0777 $DATADIR
touch $DATADIR/doquer_containers

