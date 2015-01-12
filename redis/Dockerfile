# Redis
# VERSION 0.0.1

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


# Install Redis
ADD conf/redis.setup /var/tmp/redis.setup
RUN \
: '# First that nothing create user redis' && \
	useradd -M -U -s /bin/false -u 7777 redis && \
	apt-get install -y --no-install-recommends gcc libc6-dev make && \
	setup_tool install /var/tmp/redis.setup && \
	apt-get purge -y --auto-remove gcc libc6-dev make

# install silence-unless-failed from silence-unless-failed
RUN \
	latest_url=https://raw.githubusercontent.com/phusion/phusion-server-tools/master/silence-unless-failed && \
	curl -L -o /usr/local/bin/silence-unless-failed ${latest_url} && \
	chmod a+x /usr/local/bin/silence-unless-failed

# Install msmtp: light SMTP client
RUN \
	apt-get install -y --no-install-recommends msmtp msmtp-mta && \
	ln -s /srv/conf.d/msmtp/msmtprc /etc/msmtprc

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# add init script.
ADD usr/rc.local /etc/rc.local

# create runit service´s
ADD usr/redis.sh /etc/service/redis/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
