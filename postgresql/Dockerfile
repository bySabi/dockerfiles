# PostgreSQL
# VERSION 0.0.2

FROM phusion/baseimage:latest
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


# Install PostgreSQL
ENV PG_VERSION 9.4
RUN \
	apt-key adv --keyserver pgp.mit.edu --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && \
	add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main'   && \
	apt-get update 1>/dev/null && \

:	'# First that nothing create user postgres' && \
	useradd -M -U -s /bin/false -u 7777 postgres && \
	apt-get install -q -y --no-install-recommends postgresql-common && \
	sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf && \
	apt-get install -q -y --no-install-recommends postgresql-$PG_VERSION postgresql-contrib-$PG_VERSION && \
	ln -s /usr/lib/postgresql/$PG_VERSION /usr/lib/postgresql/current && \
	/etc/init.d/postgresql stop

# add init script. Include postgresql setup
COPY usr/rc.local /etc/rc.local

# create runit service´s
COPY usr/postgresql.sh /etc/service/postgresql/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
