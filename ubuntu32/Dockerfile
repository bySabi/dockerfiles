# ubuntu 32 bits
# VERSION 0.0.1

FROM bySabi/coreubuntu32
MAINTAINER bySabi <flxinformatico@gmail.com>

ENV DEBIAN_FRONTEND noninteractive


RUN \
	locale-gen en_US en_US.UTF-8 && \
	echo "LANG=\"en_US.UTF-8\"" > /etc/default/locale && \
	echo "LANGUAGE=\"en_US:en\"" >> /etc/default/locale && \
	dpkg-reconfigure locales && \
	echo "Europe/Madrid" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata && \

	apt-get install -y software-properties-common && \
	add-apt-repository "deb http://en.archive.ubuntu.com/ubuntu saucy main universe" && \
	add-apt-repository "deb http://en.archive.ubuntu.com/ubuntu saucy-updates main universe" && \
	add-apt-repository "deb http://en.archive.ubuntu.com/ubuntu saucy-security main universe" && \
	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get -y -q autoclean && apt-get -y -q autoremove

ONBUILD RUN echo "root:$PASSWORD" |chpasswd
