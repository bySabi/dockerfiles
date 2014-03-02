# develop 32 bits
# VERSION 0.0.1

FROM bySabi/ubuntu32
MAINTAINER bySabi <flxinformatico@gmail.com>

RUN \
	apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y bash-completion && \
	apt-get install -y nano && \
	apt-get install -y openssh-server && \
	apt-get install -y mc && \

	apt-get -y install build-essential && \
	apt-get -y install git && \

	apt-get -y install libssl-dev && \
	apt-get -y install nasm && \

	apt-get -y -q autoclean && apt-get -y -q autoremove && \

	sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd


ADD usr/git-crypt /usr/local/bin/


ADD usr/run.sh /


ENTRYPOINT ["/start.sh"]
