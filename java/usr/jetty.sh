#!/bin/sh
set -e

exec \
	setuser java \
	$JETTY_HOME/bin/jetty.sh run
