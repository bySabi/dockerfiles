# nas
# VERSION 0.0.2

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
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh


RUN \
	echo deb http://en.archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list && \
	echo deb http://en.archive.ubuntu.com/ubuntu precise-updates main universe >> /etc/apt/sources.list


# pinning 700 netatalk and samba4 to apt from https://portal.enterprisesamba.com/
ADD conf/NAS-pin-700 /etc/apt/preferences.d/
ADD conf/sernet-samba-4.1.list /var/tmp/
RUN \
	apt-get update && apt-get upgrade -y -q && \

	cat /var/tmp/sernet-samba-4.1.list >> /etc/apt/sources.list && \
	curl -O http://ftp.sernet.de/pub/sernet-samba-keyring_1.4_all.deb && \
	dpkg -i sernet-samba-keyring_1.4_all.deb && \

	apt-get install -y --no-install-recommends python-software-properties && \
	add-apt-repository -y ppa:ali-asad-lotia/netatalk-stable && \
	apt-get update && \

	apt-get install -y --no-install-recommends netatalk avahi-daemon samba


# Enable "extra" users, this makes
# overlaying our passwd/shadow/group content easier
RUN \
	apt-get install -y libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf


# static patching netatalk && avahi-daemon && samba4
RUN \
	sed 's/ENABLE_DAEMON=0$/ENABLE_DAEMON=1/' -i /etc/default/netatalk && \
	sed 's/#enable-dbus=yes$/enable-dbus=no/' -i /etc/avahi/avahi-daemon.conf && \

	sed 's/SAMBA_START_MODE="none"$/SAMBA_START_MODE="classic"/' -i /etc/default/sernet-samba


# custom settings
ADD conf/afp.conf /etc/netatalk/afp.conf
ADD conf/smb.conf /etc/samba/smb.conf
ADD conf/afpd.service /etc/avahi/services/afpd.service
ADD conf/smb.service /etc/avahi/services/smb.service


# user management tool
ADD usr/nas-user /usr/local/bin/


# create runit service
RUN \
	mkdir /etc/service/netatalk && \
	mkdir /etc/service/samba4
ADD usr/netatalk.sh /etc/service/netatalk/run
ADD usr/samba4.sh /etc/service/samba4/run


# pipework --wait
RUN \
	curl -o /usr/local/bin/pipework https://raw.github.com/jpetazzo/pipework/master/pipework && \
	chmod +x /usr/local/bin/pipework && \
	mkdir /etc/service/1pipework
ADD usr/pipework.sh /etc/service/1pipework/run


ENV DATADIR /data

## volume´s
#	/data
#	/var/lib/extrausers


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
