#!/bin/sh


isrootuser(){
if ! [ $(id -u) = 0 ]; then
echo "This script must be run as root" 1>&2
exit 1
fi
}


isrootuser


service docker stop
killall docker

# set working dir to current
cd "$(dirname "$0")"

perl scripts/linux.pl

service docker start

exit 0
