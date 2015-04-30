# nas
# VERSION 0.6.0

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


## NAS

# Install samba4 from sernet enterprise repository https://portal.enterprisesamba.com/
COPY conf/sernet-samba-4.list /etc/apt/sources.list.d/sernet-samba-4.list
RUN \
	curl -L -o /var/tmp/sernet-samba-keyring_all.deb http://ftp.sernet.de/pub/sernet-samba-keyring_1.4_all.deb && \
	dpkg -i /var/tmp/sernet-samba-keyring_all.deb && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends samba
COPY conf/smb.conf /etc/samba/smb.conf


# Install avahi & netatalk from ppa repository
# CAUTION!!! Don´t use other repository than "ali-asad-lotia"
RUN \
	add-apt-repository -y ppa:ali-asad-lotia/netatalk-stable && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends netatalk avahi-daemon
COPY conf/afp.conf /etc/netatalk/afp.conf

# add avahi services
COPY conf/afpd.service /etc/avahi/services/afpd.service
#COPY conf/smbd.service /etc/avahi/services/smbd.service


# Install nfs
RUN \
	apt-get install -y --no-install-recommends nfs-kernel-server && \
	rm /etc/exports && \
	ln -s /srv/conf.d/nfs/exports /etc/exports && \
	mkdir -p /run/rpc_pipefs && \
	echo "rpc_pipefs	/run/rpc_pipefs	rpc_pipefs	defaults	0	0" >> /etc/fstab && \
	echo "nfsd	/proc/fs/nfsd	nfsd	defaults	0	0" >> /etc/fstab


# Install rsync
RUN \
	apt-get install -y --no-install-recommends rsync


# Create "nas" user
RUN \
	useradd -M -U -s /bin/false -u 7777 nas

# Enable "extra" users, this makes overlaying our passwd/shadow/group content easier
## user management tool
COPY usr/nas-user /usr/local/bin/nas-user
RUN \
	apt-get install -y --no-install-recommends libnss-extrausers && \
	sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf


# create "shared" dir
RUN \
	shared_dir="/srv/shared" && \
	mkdir -p ${shared_dir} && \
	chmod -R 775 ${shared_dir} && chown -R nas:nas ${shared_dir}


## BACKUP
# Install Google Drive client: https://github.com/odeke-em/drive
RUN \
	add-apt-repository -y ppa:twodopeshaggy/drive && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends drive


# install silence-unless-failed from silence-unless-failed
RUN \
	latest_url=https://raw.githubusercontent.com/phusion/phusion-server-tools/master/silence-unless-failed   && \
	curl -L -o /usr/local/bin/silence-unless-failed ${latest_url} && \
	chmod a+x /usr/local/bin/silence-unless-failed


# Install msmtp: light SMTP client
RUN \
	apt-get install -y --no-install-recommends msmtp msmtp-mta && \
	ln -s /srv/conf.d/msmtp/msmtprc /etc/msmtprc


# Install lsyncd
RUN \
	apt-get install -y --no-install-recommends lsyncd

# Install ipsvd super server for "rsyncd on demand"
RUN \
	apt-get install -y --no-install-recommends ipsvd


# add init script. Include pipework check.
COPY usr/rc.local /etc/rc.local

# create runit service´s
COPY usr/dbus.sh /etc/service/dbus/run
COPY usr/avahi.sh /etc/service/avahi/run
COPY usr/netatalk.sh /etc/service/netatalk/run
COPY usr/smbd.sh /etc/service/smbd/run
COPY usr/nmbd.sh /etc/service/nmbd/run
COPY usr/rpcbind.sh /etc/service/rpcbind/run
COPY usr/nfsd.sh /etc/service/nfsd/run
COPY usr/idmapd.sh /etc/service/idmapd/run
COPY usr/lsyncd.sh /etc/service/lsyncd/run
COPY usr/rsync.sh /etc/service/rsync/run


# pipework --wait
RUN \
	latest_url=https://raw.github.com/jpetazzo/pipework/master/pipework   && \
	curl -L -o /usr/local/bin/pipework ${latest_url} && \
	chmod a+x /usr/local/bin/pipework

# enable SSH
RUN rm -f /etc/service/sshd/down

# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
