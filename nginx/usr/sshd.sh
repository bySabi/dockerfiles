#!/bin/sh
set -e

exec tcpsvd -v 0 22 /usr/sbin/sshd -i
