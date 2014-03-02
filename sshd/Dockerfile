# sshd
# VERSION 0.0.1

FROM bySabi/ubuntu
MAINTAINER bySabi <flxinformatico@gmail.com>

RUN \
	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y software-properties-common && \
	apt-get install -y bash-completion && \
	apt-get install -y nano && \
	apt-get install -y openssh-server && \
	apt-get install -y mc && \

	apt-get -y -q autoclean && apt-get -y -q autoremove && \

	mkdir /var/run/sshd && \
	sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd


ADD usr/run.sh /


ENTRYPOINT ["/start.sh"]
