# youtrack
# VERSION 0.0.2

FROM bySabi/java
MAINTAINER bySabi <flxinformatico@gmail.com>

#ENV latest_youtrack_war http://download.jetbrains.com/charisma/youtrack-5.1.2.war
ENV latest_youtrack_war http://192.168.0.31:8080/youtrack-5.1.2.war

ENV WEBAPPS $JETTY_HOME/webapps
#ENV WEBAPPS $TOMCAT_HOME/webapps

# tomcat var
#ENV JAVA_OPTS -XX:MaxPermSize=150M
# jetty var
ENV JAVA_OPTIONS -XX:MaxPermSize=150M

## deploy youtrack war
RUN \
	youtrackdir=$WEBAPPS/root && \
:	'#youtrackdir=$WEBAPPS/ROOT' && \
	mkdir -p ${youtrackdir} && \
	curl -o ${youtrackdir}/youtrack.war ${latest_youtrack_war} && \
	cd ${youtrackdir}; $JAVA_HOME/bin/jar -xvf youtrack.war; rm youtrack.war && \
	chown -R java:java ${youtrackdir}


# enable runit service
RUN mv /etc/service.disable/jetty /etc/service/jetty
#RUN mv /etc/service.disable/tomcat /etc/service/tomcat


# Clean up APT when done.
RUN \
	apt-get -y -q clean && apt-get -y -q autoclean && apt-get -y -q autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
