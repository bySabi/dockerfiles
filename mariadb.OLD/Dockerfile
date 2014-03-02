# MariaDB
# VERSION 0.0.1

FROM bySabi/ubuntu
MAINTAINER bySabi <flxinformatico@gmail.com>

RUN \
	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y software-properties-common && \
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
	add-apt-repository 'deb http://mirrors.n-ix.net/mariadb/repo/5.5/ubuntu saucy main' && \
	apt-get update && \
	apt-get -q -y install mariadb-server && \

	apt-get -y -q autoclean && apt-get -y -q autoremove

# cleanup
RUN rm -r /var/lib/mysql

# a mounted file systems table to make MySQL happy
RUN cat /proc/mounts > /etc/mtab

ADD conf/my.cnf /etc/mysql/my.cnf

ENV DATADIR /data


ADD usr/run.sh /

#VOLUME /data


ENTRYPOINT ["/start.sh"]
