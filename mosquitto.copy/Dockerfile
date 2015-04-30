# mosquitto
# VERSION 0.0.3

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

COPY usr/rc.local /etc/rc.local

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
