# java
# VERSION 0.1.5

FROM phusion/baseimage:0.9.12
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


# setup_tool tools manager
RUN \
	latest_url=https://raw.githubusercontent.com/bySabi/my_docker_util/master/setup_tool/setup_tool   && \
	curl -L -o /usr/local/bin/setup_tool ${latest_url} && \
	chmod a+x /usr/local/bin/setup_tool


# Install oracle Java
ENV JAVA_HOME /usr/lib/jvm/java-oracle
ADD conf/java.setup /var/tmp/java.setup
RUN setup_tool install /var/tmp/java.setup

RUN \
	useradd --create-home -U -s /bin/false -u 7777 java


# Install Jetty
ENV JETTY_HOME /opt/jetty
ADD conf/jetty.setup /var/tmp/jetty.setup
RUN setup_tool install /var/tmp/jetty.setup


# Install Tomcat
ENV CATALINA_HOME /opt/tomcat
ADD conf/tomcat.setup /var/tmp/tomcat.setup
RUN setup_tool install /var/tmp/tomcat.setup


# Install msmtp: light SMTP client
RUN \
	apt-get install -y --no-install-recommends msmtp msmtp-mta && \
	ln -s /srv/conf.d/msmtp/msmtprc /etc/msmtprc


# Install ipsvd super server
RUN \
	apt-get install -y --no-install-recommends ipsvd


# create runit service
ADD usr/sshd.sh /etc/sshd/run

ADD usr/jetty.sh /etc/service.disable/jetty/run
ADD usr/tomcat.sh /etc/service.disable/tomcat/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
