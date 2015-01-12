# netatalk_deb
# VERSION 0.0.1

FROM bysabi/develop64
MAINTAINER bySabi <flxinformatico@gmail.com>

RUN \
	apt-get update 1>/dev/null && apt-get upgrade -y -q --no-install-recommends


# Install package needed
# http://netatalk.sourceforge.net/wiki/index.php/Install_Netatalk_3.1.7_on_Ubuntu_14.10_Utopic
RUN \
	apt-get install -y libevent-dev libssl-dev libgcrypt11-dev libkrb5-dev libpam0g-dev libwrap0-dev \
					libdb-dev libtdb-dev libmysqlclient-dev libavahi-client-dev libacl1-dev libldap2-dev \
					libcrack2-dev systemtap-sdt-dev libdbus-1-dev libdbus-glib-1-dev libglib2.0-dev \
					tracker libtracker-sparql-0.16-dev libtracker-miner-0.16-dev

# add init script
ADD usr/rc.local /etc/rc.local

# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
