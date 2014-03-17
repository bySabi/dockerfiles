#!/bin/sh
set -e

exec \
	setuser java \
	$CATALINA_HOME/bin/catalina.sh run
