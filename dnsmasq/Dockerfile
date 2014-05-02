# dnsmasq
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


# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh


# Install dnsmasq
RUN \
	apt-get install -y --no-install-recommends dnsmasq
ADD conf/dnsmasq.conf /etc/dnsmasq.conf
RUN \
	chown root:root /etc/dnsmasq.conf

# Install lsyncd: for watches a local directory trees. precise lsyncd is a little outdated
RUN \
	latest_lsyncd=http://de.archive.ubuntu.com/ubuntu/pool/universe/l/lsyncd/lsyncd_2.1.5-1_amd64.deb    && \
	apt-get install -y --no-install-recommends liblua5.1-0 lua5.1 rsync && \
	curl -L -o /var/tmp/lsyncd.deb ${latest_lsyncd} && \
	dpkg -i /var/tmp/lsyncd.deb && \
	mkdir -p /var/log/lsyncd


# create runit service´s
ADD usr/dnsmasq.sh /etc/service/dnsmasq/run
ADD usr/lsyncd.sh /etc/service/lsyncd/run
RUN \
	chown root:root -R /etc/service


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
