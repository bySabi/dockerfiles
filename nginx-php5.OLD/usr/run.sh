#!/bin/bash


echo "root:$PASSWORD" |chpasswd


# 0=true; 1=false
is_folder_empty() {
	# exist dir?
	if [ -d "$1" ]; then
		# if empty return true
		if find "$1" -maxdepth 0 -empty | read v; then return 0; fi
	fi
	return 1
}

# if empty? deploy : NOTUSED
if is_folder_empty "$DATADIR/www" ; then
	true
fi
# Already deployed?
if [ ! -f $DATADIR/.deploy ]; then
	chown -R www-data $DATADIR/www
	touch $DATADIR/.deploy
fi


service php5-fpm start
service nginx start


#not exit from script. Needed on docker
# Send SIGSTOP to itself
kill -STOP "$$"
