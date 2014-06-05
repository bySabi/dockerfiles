#!/bin/sh

exec /usr/sbin/dnsmasq -k -C /srv/conf.d/dnsmasq/dnsmasq.conf
