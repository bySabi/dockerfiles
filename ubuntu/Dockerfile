# ubuntu 13.10
# VERSION 0.0.4

FROM stackbrew/ubuntu:13.10
MAINTAINER bySabi <flxinformatico@gmail.com>

ENV DEBIAN_FRONTEND noninteractive


RUN \
	locale-gen en_US en_US.UTF-8 && \
	echo "LANG=\"en_US.UTF-8\"" > /etc/default/locale && \
	echo "LANGUAGE=\"en_US:en\"" >> /etc/default/locale && \
	dpkg-reconfigure locales && \
	echo "Europe/Madrid" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata && \

	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \
	apt-get -y -q autoclean && apt-get -y -q autoremove

ONBUILD RUN echo "root:$PASSWORD" |chpasswd
