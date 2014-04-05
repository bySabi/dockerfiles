# nas
# VERSION 0.1.0

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


# Install samba4 from sernet enterprise repository https://portal.enterprisesamba.com/
ADD conf/samba4-pin-700 /etc/apt/preferences.d/
ADD conf/sernet-samba-4.list /etc/apt/sources.list.d/
RUN \
	chown -R root:root /etc/apt/preferences.d /etc/apt/sources.list.d && \
	curl -o /var/tmp/sernet-samba-keyring_all.deb http://ftp.sernet.de/pub/sernet-samba-keyring_1.4_all.deb && \
	dpkg -i /var/tmp/sernet-samba-keyring_all.deb && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends samba


# Install avahi-daemon & netatalk from "ali-asad-lotia" ppa repository
ADD conf/netatalk-pin-700 /etc/apt/preferences.d/
RUN \
	chown -R root:root /etc/apt/preferences.d && \
	add-apt-repository -y ppa:ali-asad-lotia/netatalk-stable && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends netatalk avahi-daemon && \
:	'# disable avahi dbus support' && \
	sed 's/#enable-dbus=yes$/enable-dbus=no/' -i /etc/avahi/avahi-daemon.conf


# Install goodsync
#latest_goodsync='http://www.goodsync.com/download/goodsync-release-x86_64.tar.gz'
#latest_goodsync='http://192.168.0.29:8000/files/goodsync-release-x86_64.tar.gz'
RUN \
	latest_goodsync='http://www.goodsync.com/download/goodsync-release-x86_64.tar.gz' && \
	mkdir -p /usr/sbin/goodsync && \
	curl -o /var/tmp/goodsync.tar.gz ${latest_goodsync} && \
	tar --strip-components=1 -xvf /var/tmp/goodsync.tar.gz -C /usr/sbin/goodsync && \
	mkdir -p /var/log/goodsync

RUN \
	apt-get install -y --no-install-recommends make perl cpanminus


# Create "nas" user
RUN \
	useradd -M -U -s /bin/false -u 7777 nas

# Enable "extra" users, this makes overlaying our passwd/shadow/group content easier
## user management tool
ADD usr/nas-user /usr/local/bin/
RUN \
	chown root:root /usr/local/bin/nas-user && \
	apt-get install -y --no-install-recommends libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf


# samba custom settings
ADD conf/smb.conf /etc/samba/smb.conf
ADD conf/smb.service /etc/avahi/services/smb.service

# netatalk custom settings
ADD conf/afp.conf /etc/netatalk/afp.conf
ADD conf/afpd.service /etc/avahi/services/afpd.service
RUN \
	chown root:root /etc/netatalk/afp.conf /etc/samba/smb.conf -R /etc/avahi/services

# create "shared" dir
RUN \
	shared_dir="srv/shared" && \
	mkdir -p ${shared_dir} && \
	chmod -R 775 ${shared_dir} && chown -R nas:nas ${shared_dir}


# add init script. Include pipework check.
ADD usr/rc.local /etc/rc.local
RUN \
	chown root:root /etc/rc.local

# create runit service´s
ADD usr/avahi-daemon.sh /etc/service/avahi-daemon/run
ADD usr/netatalk.sh /etc/service/netatalk/run
ADD usr/smbd.sh /etc/service/smbd/run
ADD usr/nmbd.sh /etc/service/nmbd/run
ADD usr/goodsync.sh /etc/service/goodsync/run
ADD usr/sshd.sh /etc/service/sshd/run
RUN \
	chown root:root -R /etc/service

# pipework --wait
RUN \
	curl -o /usr/local/bin/pipework https://raw.github.com/jpetazzo/pipework/master/pipework && \
	chmod a+x /usr/local/bin/pipework


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
