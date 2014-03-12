#!/bin/bash
set -e

install -o root -m 644 "set-all-bridged-containers.conf" /etc/init/
install -o root -m 755 "await-docker-started" /etc/init.d/
update-rc.d "await-docker-started" start 80 2 3 4 5 .
