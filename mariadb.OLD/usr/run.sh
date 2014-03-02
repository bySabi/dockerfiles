#!/bin/bash


echo "root:$PASSWORD" |chpasswd


# if not exist DATADIR/mysql  deploy it
[ -d "$DATADIR/mysql" ] || {
	mkdir -p $DATADIR/mysql

	# Set datadir 
	mysql_install_db --datadir=$DATADIR/mysql
	chown -R mysql.mysql $DATADIR/mysql

	service mysql start

	# Set user/password admin and grant login from everywhere
	echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
}


service mysql start


#not exit from script. Needed on docker
# Send SIGSTOP to itself
kill -STOP "$$";
