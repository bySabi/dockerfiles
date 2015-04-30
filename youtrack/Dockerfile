# youtrack
# VERSION 0.1.2

FROM bysabi/java
MAINTAINER bySabi <flxinformatico@gmail.com>

RUN \
	apt-get update 1>/dev/null && apt-get upgrade -y -q --no-install-recommends


ENV WEBAPPS $JETTY_HOME/webapps
#ENV WEBAPPS $TOMCAT_HOME/webapps

# tomcat var
#ENV JAVA_OPTS -XX:MaxPermSize=150M
# jetty var
ENV JAVA_OPTIONS -XX:MaxPermSize=150M

## deploy youtrack war
COPY conf/youtrack.setup /var/tmp/youtrack.setup
RUN setup_tool install /var/tmp/youtrack.setup


# add init script
COPY usr/rc.local /etc/rc.local

# enable runit service
RUN mv /etc/service.disable/jetty /etc/service/jetty
#RUN mv /etc/service.disable/tomcat /etc/service/tomcat


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
