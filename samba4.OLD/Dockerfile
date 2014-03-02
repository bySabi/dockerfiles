# Samba4
# VERSION 0.0.1

FROM bySabi/ubuntu
MAINTAINER bySabi <flxinformatico@gmail.com>

ADD conf/samba4-pin-700 /etc/apt/preferences.d/samba4-pin-700

RUN \
	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y software-properties-common && \
	add-apt-repository -y "deb http://ppa.launchpad.net/kernevil/zentyal-experimental/ubuntu devel main" && \
	apt-get update && \
	apt-get install -y --force-yes samba4

# Enable "extra" users, this makes
# overlaying our passwd/shadow/group content easier
RUN \
	apt-get install -y libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf && \

	apt-get -y -q autoclean && apt-get -y -q autoremove


ADD conf/smb.conf /etc/samba/smb.conf

# Add user management tool
ADD usr/samba-user /usr/local/bin/

# for smbd & nmbd service start-stop properly
ADD usr/samba4 /etc/init.d/samba4

# pipework --wait 
ADD usr/pipework /usr/local/bin/

ENV DATADIR /data


ADD usr/run.sh /


#VOLUME /data
#VOLUME /var/lib/extrausers


ENTRYPOINT ["/start.sh"]
