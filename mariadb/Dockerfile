# MariaDB
# VERSION 0.1.0

FROM phusion/baseimage:0.9.12
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
	apt-get update 1>/dev/null && apt-get upgrade -y -q --no-install-recommends && \
	apt-get install -y --no-install-recommends software-properties-common


# Install MariaDB
RUN \
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
	add-apt-repository 'deb http://mirror.1000mbps.com/mariadb/repo/5.5/ubuntu trusty main'   && \
	apt-get update 1>/dev/null && \

:	'# First that nothing create user mysql' && \
	useradd -M -U -s /bin/false -u 7777 mysql && \
	apt-get install -q -y --no-install-recommends mariadb-server && \
:	'# cleanup' && \
	rm -r /var/lib/mysql


# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# add init script. Include mariadb setup
ADD usr/rc.local /etc/rc.local

# create runit service´s
ADD usr/mariadb.sh /etc/service/mariadb/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
