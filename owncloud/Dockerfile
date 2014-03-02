# Ownclound on Nginx
# VERSION 0.0.3

FROM bySabi/nginx-php5
MAINTAINER bySabi <flxinformatico@gmail.com>

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y php5-gd php5-json php5-sqlite php-xml-parser php5-intl curl libcurl3 php5-curl && \
	apt-get -y -q autoclean && apt-get -y -q autoremove && \

	curl -O http://download.owncloud.org/community/daily/owncloud-daily-master.tar.bz2
	#wget -q -O - http://download.owncloud.org/community/daily/owncloud-daily-master.tar.bz2 | tar jx -C /data

ADD nginx.conf /etc/nginx/nginx.conf

ENV DATADIR /data

ADD start.sh /
ADD deploy.sh /
ADD run.sh /

#VOLUME /data

CMD ["/start.sh"]
