# prosody XMPP server
# VERSION 0.0.1

FROM phusion/baseimage:0.9.9
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
	apt-get update 1>/dev/null && \
	apt-get upgrade -y -q --no-install-recommends && \
	apt-get install -y --no-install-recommends python-software-properties

# Install ipsvd super server
RUN \
	apt-get install -y --no-install-recommends ipsvd


# Install prosody
RUN \
	apt-get install -y prosody && \
	usermod -u 7777 prosody && groupmod -g 7777 prosody && \
	mkdir -p /var/run/prosody && \
	chown prosody:prosody -R /var/run/prosody /etc/prosody/prosody.cfg.lua && \

	echo 'use_libevent = true;' >> /etc/prosody/prosody.cfg.lua && \
	sed -i -e 's/Include \+\"conf.*/Include \"\/srv\/conf\/prosody\/conf.d\/\*.cfg.lua\";/' /etc/prosody/prosody.cfg.lua && \
	sed -i -e 's/daemonize \+=.*/daemonize = false;/' /etc/prosody/prosody.cfg.lua


# create runit service´s
ADD usr/sshd.sh /etc/service/sshd/run
ADD usr/prosody.sh /etc/service/prosody/run
RUN \
	chown root:root -R /etc/service


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
