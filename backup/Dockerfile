# backup
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


# Install ipsvd super server
RUN \
	apt-get install -y --no-install-recommends ipsvd


# setup_tool tools manager
RUN \
	latest_setup_tool=https://raw.githubusercontent.com/bySabi/my_docker_util/master/setup_tool/setup_tool   && \
	curl -L -o /usr/local/bin/setup_tool ${latest_setup_tool} && \
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
ADD conf/duplicity.setup /var/tmp/
RUN setup_tool install /var/tmp/duplicity.setup


# Install duply
ADD conf/duply.setup /var/tmp/
RUN setup_tool install /var/tmp/duply.setup


# Install goodsync
ADD conf/goodsync.setup /var/tmp/
RUN setup_tool install /var/tmp/goodsync.setup

RUN \
	apt-get install -y --no-install-recommends perl make cpanminus && \
	cpanm --notest HTTP::Server::Simple::CGI Net::DNS::Nameserver


# Install msmtp: light SMTP client
RUN \
	apt-get install -y --no-install-recommends msmtp
ADD conf/msmtprc /etc/


# add init script
ADD usr/rc.local /etc/rc.local

# create runit service´s
ADD usr/sshd.sh /etc/service/sshd/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
