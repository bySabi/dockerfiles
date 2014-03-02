# Nginx and PHP5
# VERSION 0.0.3

FROM bySabi/nginx
MAINTAINER bySabi <flxinformatico@gmail.com>

RUN \
	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y php5-fpm && \
	echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini && \

	apt-get -y -q autoclean && apt-get -y -q autoremove


ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/location/expires.conf /etc/nginx/conf/expires.conf
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/directive-only/x-ua-compatible.conf /etc/nginx/conf/x-ua-compatible.conf
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/location/cross-domain-fonts.conf /etc/nginx/conf/cross-domain-fonts.conf
ADD https://raw.github.com/h5bp/server-configs-nginx/master/h5bp/location/protect-system-files.conf /etc/nginx/conf/protect-system-files.conf
RUN sed -i -e '/access_log/d' /etc/nginx/conf/expires.conf && \
	sed -i -e 's/^listen =.*/listen = \/var\/run\/php5-fpm.sock/' /etc/php5/fpm/pool.d/www.conf

ADD conf/nginx.conf /etc/nginx/nginx.conf

ENV DATADIR /data


ADD usr/run.sh /


#VOLUME /data


ENTRYPOINT ["/start.sh"]
