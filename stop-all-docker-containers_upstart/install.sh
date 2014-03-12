#!/bin/bash
set -e

install -o root -m 644 "stop-all-docker-containers.conf" /etc/init/
install -o root -m 755 "await-docker-stopped" /etc/init.d/
update-rc.d "await-docker-stopped" start 19 0 6 .
