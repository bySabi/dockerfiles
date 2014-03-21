#!/bin/sh

echo $(date +%s000) >> /root/mariadb_timestamp.log
start_mariadb() {
	exec \
		setuser mysql \
		/usr/bin/mysqld_safe
}

# if not exist ${DATADIR}/mysql deploy it
[ ${DATADIR} ] && {
	if [ -d ${DATADIR}/mysql ]
	then
		chown -R mysql.mysql ${DATADIR}/mysql
	else
		mkdir -p ${DATADIR}/mysql

		# Set datadir 
		mysql_install_db --datadir=${DATADIR}/mysql
		chown -R mysql.mysql ${DATADIR}/mysql

#		sv start mariadb
		start_mariadb
		# Set user/password admin and grant login from everywhere
		echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'admin' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
	fi
}

start_mariadb
