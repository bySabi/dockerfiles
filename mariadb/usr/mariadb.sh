#!/bin/sh


# if not exist DATADIR/mysql  deploy it
[ "$DATADIR" ] && {
	[ -d "$DATADIR/mysql" ] || {
		mkdir -p $DATADIR/mysql

		# Set datadir 
		mysql_install_db --datadir=$DATADIR/mysql
		chown -R mysql.mysql $DATADIR/mysql

		/etc/init.d/mysql start

		# Set user/password admin and grant login from everywhere
		echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql

		exit 0
	}
}


/etc/init.d/mysql start
