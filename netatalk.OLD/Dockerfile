# netatalk
# VERSION 0.0.1

FROM bySabi/ubuntu
MAINTAINER bySabi <flxinformatico@gmail.com>

# pinning 700 netatalk ppa
ADD conf/netatalk-pin-700 /etc/apt/preferences.d/

RUN \
	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y software-properties-common && \
	add-apt-repository -y ppa:ali-asad-lotia/netatalk-stable && \
	apt-get update && \
	apt-get install -y netatalk avahi-daemon

# Enable "extra" users, this makes
# overlaying our passwd/shadow/group content easier
RUN \
	apt-get install -y libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf && \
	apt-get -y -q autoclean && apt-get -y -q autoremove

# static patching netatalk && avahi-daemon
RUN \
	sed 's/ENABLE_DAEMON=0$/ENABLE_DAEMON=1/' -i /etc/default/netatalk && \
	sed 's/#enable-dbus=yes$/enable-dbus=no/' -i /etc/avahi/avahi-daemon.conf


ADD conf/afp.conf /etc/netatalk/afp.conf
ADD conf/afpd.service /etc/avahi/services/afpd.service

# Add user management tool
ADD usr/netatalk-user /usr/local/bin/


# pipework --wait 
ADD usr/pipework /usr/local/bin/

ENV DATADIR /data


ADD usr/run.sh /


#VOLUME /data
#VOLUME /var/lib/extrausers


ENTRYPOINT ["/start.sh"]
