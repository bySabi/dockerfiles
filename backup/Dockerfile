# backup
# VERSION 0.0.1

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


# Install development tools
RUN \
	apt-get install -y --no-install-recommends build-essential python python-dev && \
	curl -L -O http://python-distribute.org/distribute_setup.py && \
	python distribute_setup.py && easy_install pip


# Install duplicity
RUN \
	apt-get install -y --no-install-recommends librsync-dev rsync rdiff && \
	pip install lockfile paramiko pycrypto urllib3 oauthlib boto python-swiftclient gdata && \

	latest_duplicity=http://duplicity.nongnu.org/   && \
	duplicity=$(curl -s ${latest_duplicity} | grep -m1 -Po 'http://code.launchpad.net/duplicity/(.*?).tar.gz') && \
	curl -L -o /var/tmp/duplicity.tar.gz ${duplicity} && \
	mkdir -p /var/tmp/duplicity && tar --strip-components=1 --no-same-owner -xvf /var/tmp/duplicity.tar.gz -C /var/tmp/duplicity && \
	cd /var/tmp/duplicity && python ./setup.py install


# Install duply
RUN \
	latest_duply=http://duply.net/projects/ftplicity/files/latest/download/   && \
	curl -L -o /var/tmp/duply.tar.gz ${latest_duply} && \
	tar --strip-components=1 --no-same-owner -xvf /var/tmp/duply.tar.gz -C /var/tmp && \
	install -o root -m 755 /var/tmp/duply /usr/local/bin/duply


# Install goodsync
RUN \
	latest_goodsync=http://www.goodsync.com/download/goodsync-release-x86_64.tar.gz   && \
	mkdir -p /usr/sbin/goodsync && \
	curl -L -o /srv/goodsync.tar.gz ${latest_goodsync} && \
	tar --strip-components=1 --no-same-owner -xvf /srv/goodsync.tar.gz -C /usr/sbin/goodsync && \
	mkdir -p /var/log/goodsync && \
	echo $(curl -sI ${latest_goodsync} | awk '/Content-Length/ { print $2 }' | tr -d '\r') > /usr/sbin/goodsync/versionsize

RUN \
	apt-get install -y --no-install-recommends perl make cpanminus && \
	cpanm --notest HTTP::Server::Simple::CGI && \
	cpanm --notest Net::DNS::Nameserver


# Install msmtp: light SMTP client
RUN \
	apt-get install -y --no-install-recommends msmtp
ADD conf/msmtprc /etc/


# create runit service´s
ADD usr/sshd.sh /etc/service/sshd/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
