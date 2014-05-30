# nas
# VERSION 0.3.2

FROM phusion/baseimage:latest
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
	apt-get update 1>/dev/null && apt-get upgrade -y -q --no-install-recommends && \
	apt-get install -y --no-install-recommends software-properties-common


# Install samba4 from sernet enterprise repository https://portal.enterprisesamba.com/
ADD conf/samba4-pin-700 /etc/apt/preferences.d/samba4-pin-700
ADD conf/sernet-samba-4.list /etc/apt/sources.list.d/sernet-samba-4.list
RUN \
	curl -L -o /var/tmp/sernet-samba-keyring_all.deb http://ftp.sernet.de/pub/sernet-samba-keyring_1.4_all.deb && \
	dpkg -i /var/tmp/sernet-samba-keyring_all.deb && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends samba
ADD conf/smb.conf /etc/samba/smb.conf


# Install avahi & netatalk from "ali-asad-lotia" ppa repository
ADD conf/netatalk-pin-700 /etc/apt/preferences.d/netatalk-pin-700
RUN \
	add-apt-repository -y ppa:ali-asad-lotia/netatalk-stable && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends netatalk avahi-daemon
ADD conf/afp.conf /etc/netatalk/afp.conf


# Install nfs
RUN \
	apt-get install -y --no-install-recommends nfs-kernel-server && \
	rm /etc/exports && \
	mkdir -p /var/lib/nfs/rpc_pipefs && \
	echo "rpc_pipefs	/var/lib/nfs/rpc_pipefs	rpc_pipefs	defaults	0	0" >> /etc/fstab && \
	echo "nfsd	/proc/fs/nfsd	nfsd	defaults	0	0" >> /etc/fstab


# Install rsync
RUN \
	apt-get install -y --no-install-recommends rsync


# Install lsyncd
RUN \
	apt-get install -y --no-install-recommends lsyncd && \
	mkdir -p /var/log/lsyncd


# Create "nas" user
RUN \
	useradd -M -U -s /bin/false -u 7777 nas

# Enable "extra" users, this makes overlaying our passwd/shadow/group content easier
## user management tool
ADD usr/nas-user /usr/local/bin/nas-user
RUN \
	apt-get install -y --no-install-recommends libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf


# create "shared" dir
RUN \
	shared_dir="/srv/shared" && \
	mkdir -p ${shared_dir} && \
	chmod -R 775 ${shared_dir} && chown -R nas:nas ${shared_dir}


# add init script. Include pipework check.
ADD usr/rc.local /etc/rc.local

# create runit service´s
ADD usr/dbus.sh /etc/service/dbus/run
ADD usr/avahi.sh /etc/service/avahi/run
ADD usr/netatalk.sh /etc/service/netatalk/run
ADD usr/smbd.sh /etc/service/smbd/run
ADD usr/nmbd.sh /etc/service/nmbd/run
ADD usr/rpcbind.sh /etc/service/rpcbind/run
ADD usr/nfsd.sh /etc/service/nfsd/run
ADD usr/idmapd.sh /etc/service/idmapd/run
ADD usr/lsyncd.sh /etc/service/lsyncd/run
ADD usr/rsync.sh /etc/service/rsync/run


# pipework --wait
RUN \
	latest_url=https://raw.github.com/jpetazzo/pipework/master/pipework   && \
	curl -L -o /usr/local/bin/pipework ${latest_url} && \
	chmod a+x /usr/local/bin/pipework


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
