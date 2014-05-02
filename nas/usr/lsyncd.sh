#!/bin/sh

exec /usr/bin/lsyncd -nodaemon /srv/conf.d/lsyncd/lsyncd.lua
