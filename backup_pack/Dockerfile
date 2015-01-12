# backup_pack only
# VERSION 0.1.4

FROM phusion/baseimage:0.9.15
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
	curl -L -o /var/tmp/distribute_setup.py http://python-distribute.org/distribute_setup.py && \
	python /var/tmp/distribute_setup.py && \
	easy_install pip


# Install duplicity
RUN \
	apt-get install -y --no-install-recommends librsync-dev rsync rdiff && \
	pip install lockfile paramiko pycrypto urllib3 oauthlib boto python-swiftclient gdata
ADD conf/duplicity.setup /var/tmp/duplicity.setup
RUN setup_tool install /var/tmp/duplicity.setup


# Install duply
ADD conf/duply.setup /var/tmp/duply.setup
RUN setup_tool install /var/tmp/duply.setup

# Install goodsync
ADD conf/goodsync.setup /var/tmp/goodsync.setup
RUN setup_tool install /var/tmp/goodsync.setup

RUN \
	apt-get install -y --no-install-recommends perl make cpanminus && \
	cpanm --notest HTTP::Server::Simple::CGI Net::DNS::Nameserver


# install silence-unless-failed from silence-unless-failed
RUN \
	latest_url=https://raw.githubusercontent.com/phusion/phusion-server-tools/master/silence-unless-failed   && \
	curl -L -o /usr/local/bin/silence-unless-failed ${latest_url} && \
	chmod a+x /usr/local/bin/silence-unless-failed


# Install msmtp: light SMTP client
RUN \
	apt-get install -y --no-install-recommends msmtp msmtp-mta && \
	ln -s /srv/conf.d/msmtp/msmtprc /etc/msmtprc


# Install lsyncd
#RUN \
#	apt-get install -y --no-install-recommends lsyncd


# Install ipsvd super server
RUN \
	apt-get install -y --no-install-recommends ipsvd


# add init script
ADD usr/rc.local /etc/rc.local

# create runit service´s
#ADD usr/nfs_automount.sh /etc/service/nfs_automount/run
#ADD usr/lsyncd.sh /etc/service/lsyncd/run
ADD usr/sshd.sh /etc/service/sshd/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
