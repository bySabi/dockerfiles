# develop 64 bits
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


RUN \
	apt-get install -y bash-completion && \
	apt-get install -y nano && \
	apt-get install -y mc && \

	apt-get -y install build-essential && \
	apt-get -y install git

## Python virtual environment
RUN \
	curl -L -O http://python-distribute.org/distribute_setup.py && \
	python3 distribute_setup.py && \
	easy_install pip && \

	pip install virtualenv && \
	pip install virtualenvwrapper


ADD usr/git-crypt /usr/local/bin/


# add init script
ADD usr/rc.local /etc/rc.local


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
