# golang
# VERSION 0.0.2

FROM bySabi/ubuntu
MAINTAINER bySabi <flxinformatico@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && \

	apt-get install -y software-properties-common && \
	apt-get install -y curl && \
	apt-get install -y bash-completion && \
	apt-get -y -q autoclean && apt-get -y -q autoremove && \

	curl -s https://go.googlecode.com/files/go1.1.2.linux-amd64.tar.gz | tar -v -C /opt -xz && \
	cp -a /opt/go/* /usr/local/ && \
	rm -rf /opt/go

ENV GOROOT /usr/local/

VOLUME /data


