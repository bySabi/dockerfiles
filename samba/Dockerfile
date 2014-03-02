# Samba
# VERSION 0.0.1

FROM bySabi/ubuntu
MAINTAINER bySabi <flxinformatico@gmail.com>

RUN \
	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y samba

# Enable "extra" users, this makes
# overlaying our passwd/shadow/group content easier
RUN \
	apt-get install -y libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf && \

	apt-get -y -q autoclean && apt-get -y -q autoremove

ADD conf/smb.conf /etc/samba/smb.conf

# Add user management tool
ADD usr/samba-user /usr/local/bin/

# pipework --wait 
ADD usr/pipework /usr/local/bin/

ENV DATADIR /data


ADD usr/run.sh /


#VOLUME /data
#VOLUME /var/lib/extrausers


ENTRYPOINT ["/start.sh"]
