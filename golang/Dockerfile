# golang
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
	apt-get upgrade -y -q --no-install-recommends

RUN \
	apt-get install -y --no-install-recommends python-software-properties && \
:	'## Install ipsvd super server' && \
	apt-get install -y --no-install-recommends ipsvd


RUN \
	apt-get install -y --no-install-recommends build-essential mercurial git-core subversion

# env vars
ENV GOPATH /root/go
ENV PATH /root/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# Install golang
RUN \
	mkdir -p ${GOPATH} && \
	golang=$(curl -s https://code.google.com/p/go/downloads/list | grep -Po 'go(.*).linux-amd64.tar.gz\"' | sed 's|"||') && \
	curl -o /tmp/go.tar.gz https://${golang} && \
	tar -xvf /tmp/go.tar.gz -C /usr/local


# create runit service
ADD usr/sshd.sh /etc/service/sshd/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
