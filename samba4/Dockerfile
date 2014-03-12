# Samba4
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

## Add samba 4 to apt from https://portal.enterprisesamba.com/
ADD conf/samba4-pin-700 /etc/apt/preferences.d/samba4-pin-700
ADD conf/sernet-samba-4.1.list /var/tmp/
RUN \
	cat /var/tmp/sernet-samba-4.1.list >> /etc/apt/sources.list && \
	curl -o /var/tmp/sernet-samba-keyring_1.4_all.deb http://ftp.sernet.de/pub/sernet-samba-keyring_1.4_all.deb && \
	dpkg -i /var/tmp/sernet-samba-keyring_1.4_all.deb && \
	apt-get update && apt-get upgrade -y -q

## install & change SAMBA_START_MODE="none" to "classic"
RUN \
	apt-get install -y --no-install-recommends samba && \
	sed 's/SAMBA_START_MODE="none"$/SAMBA_START_MODE="classic"/' -i /etc/default/sernet-samba

ADD conf/smb.conf /etc/samba/smb.conf


# Enable "extra" users, this makes
# overlaying our passwd/shadow/group content easier
RUN \
	apt-get install -y --no-install-recommends libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf

# Add user management tool
ADD usr/samba-user /usr/local/bin/


# create runit service
RUN mkdir /etc/service/samba4
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
