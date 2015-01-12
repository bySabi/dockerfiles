# develop 64 bits
# VERSION 0.0.6

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


ENV PATH /root/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
RUN \
	apt-get install -y --no-install-recommends nano mc bash-completion && \

	apt-get install -y build-essential autoconf libtool && \
	apt-get install -y mercurial git subversion


## Python 3 virtual environment
RUN \
	curl -L -o /var/tmp/ez_setup.py https://bootstrap.pypa.io/ez_setup.py && \
	python3 /var/tmp/ez_setup.py && \
	easy_install pip && \

	pip install virtualenv && \
	pip install virtualenvwrapper


# Install golang
#ENV GOPATH /root/develop/go
#ADD conf/golang.setup /var/tmp/golang.setup
#RUN setup_tool install /var/tmp/golang.setup


# Install git-crypt
RUN \
	latest_url=https://github.com/bySabi/git-crypt/raw/build/build/git-crypt   && \
	curl -L -o /usr/local/bin/git-crypt ${latest_url} && \
	chmod a+x /usr/local/bin/git-crypt


# add init script
ADD usr/rc.local /etc/rc.local


# Cleanup 
RUN \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
