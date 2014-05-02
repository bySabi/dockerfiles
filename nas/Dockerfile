# nas
# VERSION 0.1.6

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
	curl -L -o /var/tmp/sernet-samba-keyring_all.deb http://ftp.sernet.de/pub/sernet-samba-keyring_1.4_all.deb && \
	dpkg -i /var/tmp/sernet-samba-keyring_all.deb && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends samba

# samba custom settings
ADD conf/smb.conf /etc/samba/smb.conf
RUN chown root:root /etc/samba/smb.conf


# Install avahi & netatalk from "ali-asad-lotia" ppa repository
ADD conf/netatalk-pin-700 /etc/apt/preferences.d/
RUN \
	chown -R root:root /etc/apt/preferences.d && \
	add-apt-repository -y ppa:ali-asad-lotia/netatalk-stable && \
	apt-get update 1>/dev/null && \
	apt-get install -y --no-install-recommends netatalk avahi-daemon

# netatalk custom settings
ADD conf/afp.conf /etc/netatalk/afp.conf
RUN chown root:root /etc/netatalk/afp.conf


# Install goodsync
RUN \
	latest_goodsync=http://www.goodsync.com/download/goodsync-release-x86_64.tar.gz   && \
	mkdir -p /usr/sbin/goodsync && \
	curl -L -o /srv/goodsync.tar.gz ${latest_goodsync} && \
	tar --strip-components=1 -xvf /srv/goodsync.tar.gz -C /usr/sbin/goodsync && \
	mkdir -p /var/log/goodsync && \
	echo $(curl -sI ${latest_goodsync} | awk '/Content-Length/ { print $2 }' | tr -d '\r') > /usr/sbin/goodsync/versionsize

RUN \
	apt-get install -y --no-install-recommends make perl cpanminus && \
	cpanm --notest HTTP::Server::Simple::CGI && \
	cpanm --notest Net::DNS::Nameserver


# Install lsyncd: for watches a local directory trees. precise lsyncd is a little outdated
RUN \
	latest_lsyncd=http://de.archive.ubuntu.com/ubuntu/pool/universe/l/lsyncd/lsyncd_2.1.5-1_amd64.deb    && \
	apt-get install -y --no-install-recommends liblua5.1-0 lua5.1 rsync && \
	curl -L -o /var/tmp/lsyncd.deb ${latest_lsyncd} && \
	dpkg -i /var/tmp/lsyncd.deb && \
	mkdir -p /var/log/lsyncd


# Install msmtp: light SMTP client
ADD conf/msmtprc /etc/
## precise msmtp is a little outdated
RUN \
	latest_msmtp=http://ftp.de.debian.org/debian/pool/main/m/msmtp/msmtp_1.4.32-1_amd64.deb   && \
	apt-get install -y --no-install-recommends libgsasl7 && \
	curl -L -o /var/tmp/msmtp.deb ${latest_msmtp} && \
	dpkg -x /var/tmp/msmtp.deb /tmp && \
	install -o root -m 755 /tmp/usr/bin/msmtp /usr/bin/msmtp && \
	chown root:root /etc/msmtprc && \
	ln -s /usr/bin/msmtp /usr/sbin/sendmail


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


# create "shared" dir
RUN \
	shared_dir="/srv/shared" && \
	mkdir -p ${shared_dir} && \
	chmod -R 775 ${shared_dir} && chown -R nas:nas ${shared_dir}


# add init script. Include pipework check.
ADD usr/rc.local /etc/rc.local
RUN \
	chown root:root /etc/rc.local

# create runit service´s
ADD usr/dbus.sh /etc/service/dbus/run
ADD usr/avahi.sh /etc/service/avahi/run
ADD usr/netatalk.sh /etc/service/netatalk/run
ADD usr/smbd.sh /etc/service/smbd/run
ADD usr/nmbd.sh /etc/service/nmbd/run
ADD usr/goodsync.sh /etc/service/goodsync/run
ADD usr/sshd.sh /etc/service/sshd/run
ADD usr/lsyncd.sh /etc/service/lsyncd/run
RUN \
	chown root:root -R /etc/service

# pipework --wait
RUN \
	latest_pipework=https://raw.github.com/jpetazzo/pipework/master/pipework   && \
	curl -L -o /usr/local/bin/pipework ${latest_pipework} && \
	chmod a+x /usr/local/bin/pipework


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
