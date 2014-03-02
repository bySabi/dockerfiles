# netatalk
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


# pinning 700 netatalk ppa
ADD conf/netatalk-pin-700 /etc/apt/preferences.d/

RUN \
	apt-get update && apt-get upgrade -y -q && \
	apt-get install -y --no-install-recommends python-software-properties && \
	add-apt-repository -y ppa:ali-asad-lotia/netatalk-stable && \
	apt-get update && \
	apt-get install -y --no-install-recommends netatalk avahi-daemon


# Enable "extra" users, this makes
# overlaying our passwd/shadow/group content easier
RUN \
	apt-get install -y libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf


# static patching netatalk && avahi-daemon
RUN \
	sed 's/ENABLE_DAEMON=0$/ENABLE_DAEMON=1/' -i /etc/default/netatalk && \
	sed 's/#enable-dbus=yes$/enable-dbus=no/' -i /etc/avahi/avahi-daemon.conf


ADD conf/afp.conf /etc/netatalk/afp.conf
ADD conf/afpd.service /etc/avahi/services/afpd.service

# Add user management tool
ADD usr/netatalk-user /usr/local/bin/


# create runit service
RUN mkdir /etc/service/netatalk
ADD usr/netatalk.sh /etc/service/netatalk/run


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
