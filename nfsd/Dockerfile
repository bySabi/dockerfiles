# nfs
# VERSION 0.0.3

FROM phusion/baseimage:0.9.10
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


# Install ipsvd super server
RUN \
	apt-get install -y --no-install-recommends ipsvd


# Install 
RUN \
	apt-get install -y --no-install-recommends nfs-kernel-server


# add init script. Include pipework check.
ADD usr/rc.local /etc/rc.local


# create runit service´s
ADD usr/sshd.sh /etc/service/sshd/run
ADD usr/rpcbind.sh /etc/service/rpcbind/run
ADD usr/nfsd.sh /etc/service/nfsd/run
ADD usr/idmapd.sh /etc/service/idmapd/run


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
