# Nginx
# VERSION 0.0.3

FROM bySabi/ubuntu
MAINTAINER bySabi <flxinformatico@gmail.com>

RUN apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q

ADD conf/nginx-stable-pin-700 /etc/apt/preferences.d/nginx-stable-pin-700

RUN \
	apt-get install -y software-properties-common && \
	add-apt-repository -y ppa:nginx/stable && \
	apt-get update && \
	apt-get install -y nginx && \

	apt-get -y -q autoclean && apt-get -y -q autoremove

ADD conf/nginx.conf /etc/nginx/nginx.conf


ENV DATADIR /data


ADD usr/run.sh /


#VOLUME /data


ENTRYPOINT ["/start.sh"]
