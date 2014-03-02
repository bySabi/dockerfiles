#!/bin/bash

if [ ! -f $DATADIR/.deploy ]; then
	rm -fr $DATADIR/www

	tar xjf owncloud-daily-master.tar.bz2 -C $DATADIR/
	mv -f $DATADIR/owncloud $DATADIR/www

	chown -R www-data $DATADIR/www

	touch $DATADIR/.deploy
fi