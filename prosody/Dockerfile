# prosody XMPP server
# VERSION 0.0.4

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


# Install prosody
RUN \
	apt-get install -y prosody && \
	usermod -u 7777 prosody && groupmod -g 7777 prosody && \
	mkdir -p /var/run/prosody && \
	chown prosody:prosody -R /var/run/prosody /etc/prosody/prosody.cfg.lua && \

	echo 'use_libevent = true;' >> /etc/prosody/prosody.cfg.lua && \
	sed -i -e 's/Include \+\"conf.*/Include \"\/srv\/conf.d\/prosody\/conf.d\/\*.cfg.lua\";/' /etc/prosody/prosody.cfg.lua && \
	sed -i -e 's/daemonize \+=.*/daemonize = false;/' /etc/prosody/prosody.cfg.lua


# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# create runit service´s
ADD usr/prosody.sh /etc/service/prosody/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
