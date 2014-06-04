# mosquitto
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


# Install Mosquitto MQTT Broker Server
RUN \
	add-apt-repository -y ppa:mosquitto-dev/mosquitto-ppa && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends mosquitto mosquitto-clients


ADD usr/mosquitto.sh /etc/service/mosquitto/run


#mosquitto_sub -h dns.iguanalab.lan -d -t hello/world
#mosquitto_pub -h dns.iguanalab.lan -d -t hello/world -m "La prueba"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
