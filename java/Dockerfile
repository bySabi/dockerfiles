# java
# VERSION 0.0.3

FROM phusion/baseimage:0.9.8
MAINTAINER bySabi <flxinformatico@gmail.com>


# Set correct environment variables.
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN \
	echo "Europe/Madrid" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata


#ENV latest_jdk http://www.reucon.com/cdn/java/jdk-7u51-linux-x64.tar.gz
ENV latest_jdk http://192.168.0.31:8080/jdk-7u51-linux-x64.tar.gz
ENV mirror_jetty http://ftp.fau.de/eclipse/jetty/stable-9/dist
ENV mirror_tomcat http://ftp.nluug.nl/internet/apache/tomcat/tomcat-7


RUN \
	echo deb http://en.archive.ubuntu.com/ubuntu precise main universe > /etc/apt/sources.list && \
	echo deb http://en.archive.ubuntu.com/ubuntu precise-updates main universe >> /etc/apt/sources.list && \
	apt-get update && apt-get upgrade -y -q --no-install-recommends && \

:	'## Install ipsvd super server' && \
	apt-get install -y --no-install-recommends ipsvd


# Install oracle jdk
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
RUN \
	mkdir -p $JAVA_HOME && \

	curl ${latest_jdk} | tar -v --strip-components=1 -C $JAVA_HOME -xz && \
	update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && \

	useradd --create-home java


# Install latest Jetty
ENV JETTY_HOME /opt/jetty
RUN \
	mkdir -p $JETTY_HOME && \

	eljetty=$(curl -s ${mirror_jetty}/ | grep -Po 'jetty-distribution-(.*).tar.gz\"' | sed 's|"||') && \
	curl ${mirror_jetty}/${eljetty} | tar -v --strip-components=1 -C $JETTY_HOME -xz && \

	rm -rf $JETTY_HOME/webapps.demo && \
	chown -R java:java $JETTY_HOME && chown -R 775 $JETTY_HOME/webapps


# Install latest Tomcat
ENV CATALINA_HOME /opt/tomcat
RUN \
	mkdir -p $CATALINA_HOME && \

	v=$(curl -s ${mirror_tomcat}/ | grep -Po 'v(.*)/\"' | sed 's|/"||') && \
	tom=$(curl -s ${mirror_tomcat}/${v}/bin/ | grep -Po 'apache-tomcat-(.*)[0-9].tar.gz\"' | sed 's|"||') && \
	curl ${mirror_tomcat}/${v}/bin/${tom} | tar -v --strip-components=1 -C $CATALINA_HOME -xz && \

	chown -R java:java $CATALINA_HOME && chown -R 775 $CATALINA_HOME/webapps


# create runit service
ADD usr/sshd.sh /etc/service/sshd/run
ADD usr/jetty.sh /etc/service.disable/jetty/run
ADD usr/tomcat.sh /etc/service.disable/tomcat/run


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]