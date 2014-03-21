# MariaDB
# VERSION 0.0.3

FROM phusion/baseimage:0.9.8
MAINTAINER bySabi <flxinformatico@gmail.com>


# Set correct environment variables.
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN \
	echo "Europe/Madrid" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

RUN \
	echo deb http://en.archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list && \
	echo deb http://en.archive.ubuntu.com/ubuntu precise-updates main universe >> /etc/apt/sources.list && \
	apt-get update && apt-get upgrade -y -q --no-install-recommends

RUN \
	apt-get install -y --no-install-recommends python-software-properties


# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh


#Install MariaDB
ENV DATADIR /srv/data
RUN \
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
	add-apt-repository 'deb http://mirror.1000mbps.com/mariadb/repo/5.5/ubuntu precise main' && \
	apt-get update && apt-get install -q -y --no-install-recommends mariadb-server && \

:	'# cleanup' && \
	rm -r /var/lib/mysql && \
:	'# a mounted file systems table to make MariaDB happy' && \
	cat /proc/mounts > /etc/mtab

# set a custom my.cnf
ADD conf/my.cnf /etc/mysql/my.cnf


# add init script. Include mariadb setup
#ADD usr/rc.local /etc/rc.local


# create runit service
ADD usr/mariadb.sh /etc/service/mariadb/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
