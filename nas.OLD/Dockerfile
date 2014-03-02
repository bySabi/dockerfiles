# nas
# VERSION 0.0.1

FROM bySabi/ubuntu
MAINTAINER bySabi <flxinformatico@gmail.com>

# pinning 700 netatalk and samba4 ppa
ADD conf/NAS-pin-700 /etc/apt/preferences.d/

RUN \
	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y software-properties-common && \
	add-apt-repository -y ppa:ali-asad-lotia/netatalk-stable && \
	add-apt-repository -y "deb http://ppa.launchpad.net/kernevil/zentyal-experimental/ubuntu devel main" && \
	apt-get update && \
	apt-get install -y netatalk avahi-daemon && \
	apt-get install -y --force-yes samba4

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

# custom settings
ADD conf/afp.conf /etc/netatalk/afp.conf
ADD conf/smb.conf /etc/samba/smb.conf
ADD conf/afpd.service /etc/avahi/services/afpd.service
ADD conf/smb.service /etc/avahi/services/smb.service


# user management tool
ADD usr/nas-user /usr/local/bin/

# for smbd & nmbd service start-stop properly
ADD usr/samba4 /etc/init.d/samba4

# pipework --wait 
ADD usr/pipework /usr/local/bin/

ENV DATADIR /data


ADD usr/run.sh /


#VOLUME /data
#VOLUME /var/lib/extrausers


ENTRYPOINT ["/start.sh"]
