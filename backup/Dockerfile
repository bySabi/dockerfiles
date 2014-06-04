# backup
# VERSION 0.1.1

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


# setup_tool tools manager
RUN \
	latest_url=https://raw.githubusercontent.com/bySabi/my_docker_util/master/setup_tool/setup_tool   && \
	curl -L -o /usr/local/bin/setup_tool ${latest_url} && \
	chmod a+x /usr/local/bin/setup_tool


# Install development tools
RUN \
	apt-get install -y --no-install-recommends build-essential python python-dev && \
	curl -L -O http://python-distribute.org/distribute_setup.py && \
	python distribute_setup.py && easy_install pip


# Install duplicity
RUN \
	apt-get install -y --no-install-recommends librsync-dev rsync rdiff && \
	pip install lockfile paramiko pycrypto urllib3 oauthlib boto python-swiftclient gdata
ADD conf/duplicity.setup /var/tmp/duplicity.setup
RUN setup_tool install /var/tmp/duplicity.setup


# Install duply
ADD conf/duply.setup /var/tmp/duply.setup
RUN setup_tool install /var/tmp/duply.setup


# Install nfs client
RUN \
	apt-get install -y --no-install-recommends nfs-common

# install nfs_automount
RUN \
	latest_url=https://raw.githubusercontent.com/vwal/nfs_automount/master/nfs_automount   && \
	curl -L -o /usr/local/bin/nfs_automount ${latest_url} && \
	chmod a+x /usr/local/bin/nfs_automount


# Install msmtp: light SMTP client
RUN \
	apt-get install -y --no-install-recommends msmtp
ADD conf/msmtprc /etc/msmtprc


# Install lsyncd
RUN \
	apt-get install -y --no-install-recommends lsyncd && \
	mkdir -p /var/log/lsyncd


# Install ipsvd super server
RUN \
	apt-get install -y --no-install-recommends ipsvd


# add init script
ADD usr/rc.local /etc/rc.local

# create runit service´s
ADD usr/nfs_automount.sh /etc/service/nfs_automount/run
ADD usr/lsyncd.sh /etc/service/lsyncd/run
ADD usr/sshd.sh /etc/service/sshd/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
