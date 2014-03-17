# nas
# VERSION 0.0.6

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

# Disable SSH
#RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh


RUN \
	echo deb http://en.archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list && \
	echo deb http://en.archive.ubuntu.com/ubuntu precise-updates main universe >> /etc/apt/sources.list


# pinning 700 netatalk and samba4 to apt from https://portal.enterprisesamba.com/
ADD conf/NAS-pin-700 /etc/apt/preferences.d/
ADD conf/sernet-samba-4.1.list /var/tmp/
RUN \
	apt-get update && apt-get upgrade -y -q --no-install-recommends && \
:	'## Install ipsvd super server' && \
	apt-get install -y --no-install-recommends ipsvd && \

:	'## Set sernet samba4 enterprise repository' && \
	cat /var/tmp/sernet-samba-4.1.list >> /etc/apt/sources.list && \
	curl -o /var/tmp/sernet-samba-keyring_1.4_all.deb http://ftp.sernet.de/pub/sernet-samba-keyring_1.4_all.deb && \
	dpkg -i /var/tmp/sernet-samba-keyring_1.4_all.deb && \

:	'## Set netatalk ppa repository' && \
	apt-get install -y --no-install-recommends python-software-properties && \
	add-apt-repository -y ppa:ali-asad-lotia/netatalk-stable && \

	apt-get update && \

:	'## Install netatalk, avahi-daemon and samba' && \
	apt-get install -y --no-install-recommends netatalk avahi-daemon samba && \
:	'# disable avahi dbus support' && \
	sed 's/#enable-dbus=yes$/enable-dbus=no/' -i /etc/avahi/avahi-daemon.conf && \

:	'## Install goodsync' && \
	curl -s http://www.goodsync.com/download/goodsync-release-x86_64.tar.gz | tar -v -C /usr/sbin -xz && \
	chown -R root:root /usr/sbin/goodsync-release-x86_64 && \
	ln -s /usr/sbin/goodsync-release-x86_64 /usr/sbin/goodsync && \

	apt-get install -y --no-install-recommends make perl cpanminus && \

:	'# Enable "extra" users, this makes \
	# overlaying our passwd/shadow/group content easier' && \
	apt-get install -y libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf


# afp and smb custom settings
ADD conf/afp.conf /etc/netatalk/afp.conf
ADD conf/smb.conf /etc/samba/smb.conf
ADD conf/afpd.service /etc/avahi/services/afpd.service
ADD conf/smb.service /etc/avahi/services/smb.service


# user management tool
ADD usr/nas-user /usr/local/bin/

# xinetd services
#ADD conf/sshd /etc/xinetd.d/

# init script. pipework check.
ADD usr/rc.local /etc/rc.local

# create runit service
ADD usr/avahi-daemon.sh /etc/service/avahi-daemon/run
ADD usr/netatalk.sh /etc/service/netatalk/run
ADD usr/smbd.sh /etc/service/smbd/run
ADD usr/nmbd.sh /etc/service/nmbd/run
ADD usr/goodsync.sh /etc/service/goodsync/run
ADD usr/sshd.sh /etc/service/sshd/run
#ADD usr/xinetd.sh /etc/service/xinetd/run


# pipework --wait
RUN \
	curl -o /usr/local/bin/pipework https://raw.github.com/jpetazzo/pipework/master/pipework && \
	chmod a+x /usr/local/bin/pipework


ENV DATADIR /data
ENV CONFDIR /etc/conf


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
