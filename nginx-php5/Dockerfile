# nginx and php5
# VERSION 0.0.4

FROM phusion/baseimage:0.9.8
MAINTAINER bySabi <flxinformatico@gmail.com>

# Set correct environment variables.
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN \
	echo "Europe/Madrid" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN \
	echo deb http://en.archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list && \
	echo deb http://en.archive.ubuntu.com/ubuntu precise-updates main universe >> /etc/apt/sources.list

ADD conf/nginx-stable-pin-700 /etc/apt/preferences.d/nginx-stable-pin-700

RUN \
	apt-get update && apt-get upgrade -y -q && \

	apt-get install -y --no-install-recommends python-software-properties && \
	add-apt-repository -y ppa:nginx/stable && \
	apt-get update && \
	apt-get install -y --no-install-recommends nginx php5-fpm && \
	echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini

ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/location/expires.conf /etc/nginx/conf/expires.conf
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/directive-only/x-ua-compatible.conf /etc/nginx/conf/x-ua-compatible.conf
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/location/cross-domain-fonts.conf /etc/nginx/conf/cross-domain-fonts.conf
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/location/protect-system-files.conf /etc/nginx/conf/protect-system-files.conf
RUN \
	sed -i -e '/access_log/d' /etc/nginx/conf/expires.conf && \
	sed -i -e 's/^listen =.*/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf

ADD conf/nginx.conf /etc/nginx/nginx.conf


ENV DATADIR /data


# create runit service
RUN mkdir /etc/service/nginx
ADD usr/nginx.sh /etc/service/nginx/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
