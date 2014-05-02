# nginx and php5
# VERSION 0.0.7

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
	apt-get upgrade -y -q --no-install-recommends && \
	apt-get install -y --no-install-recommends python-software-properties

# Install ipsvd super server
RUN \
	apt-get install -y --no-install-recommends ipsvd

# Install php5-fpm
RUN \
	apt-get install -y --no-install-recommends php5-fpm php5-mysql php5-gd php5-intl php5-imagick php5-mcrypt php5-curl php5-cli php5-xdebug && \

	echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini && \
	sed -i -e 's/^listen =.*/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf && \
	sed -i -e 's/;daemonize =.*/daemonize = no/' /etc/php5/fpm/php-fpm.conf

# Install nginx
ADD conf/nginx-stable-pin-700 /etc/apt/preferences.d/nginx-stable-pin-700
RUN \
	chown -R root:root /etc/apt/preferences.d /etc/apt/sources.list.d && \
	add-apt-repository -y ppa:nginx/stable && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends nginx

# Create "www" user
RUN \
	useradd -M -U -s /bin/false -u 7777 www

RUN \
	apt-get install -y --no-install-recommends git-core

# h5bp settings: https://github.com/h5bp/server-configs-nginx
RUN \
	cd /etc/nginx && \
	git init && \
	git remote add origin https://github.com/h5bp/server-configs-nginx.git && \
	git fetch --all && git reset --hard origin/master && \

	sed -i -e 's/access_log \+logs\/.*/access_log  \/var\/log\/nginx\/static.log;/' /etc/nginx/h5bp/location/expires.conf && \

	sed -i -e 's/events \+{/daemon off;\n\nevents {/' /etc/nginx/nginx.conf && \
	sed -i -e 's/include \+sites-enabled.*/include \/srv\/conf.d\/nginx\/sites-enabled\/\*;/' /etc/nginx/nginx.conf && \
	sed -i -e 's/error_log \+logs\/.*/error_log  \/var\/log\/nginx\/error.log warn;/' /etc/nginx/nginx.conf && \
	sed -i -e 's/access_log \+logs\/.*/access_log  \/var\/log\/nginx\/access.log main;/' /etc/nginx/nginx.conf


# create runit service´s
ADD usr/sshd.sh /etc/service/sshd/run
ADD usr/php5-fpm.sh /etc/service/php5-fpm/run
ADD usr/nginx.sh /etc/service/nginx/run
RUN \
	chown root:root -R /etc/service


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
