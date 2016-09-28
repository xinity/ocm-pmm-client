FROM debian:jessie

MAINTAINER Rachid Zarouali <rzarouali@gmail.com>

RUN echo "APT::Install-Recommends              false;" >> /etc/apt/apt.conf.d/recommends.conf \
    && echo "APT::Install-Suggests                false;" >> /etc/apt/apt.conf.d/recommends.conf \
    && echo "APT::AutoRemove::RecommendsImportant false;" >> /etc/apt/apt.conf.d/recommends.conf \
    && echo "APT::AutoRemove::SuggestsImportant   false;" >> /etc/apt/apt.conf.d/recommends.conf 

ENV PMM_VERSION=1.0.4-1

WORKDIR /tmp
RUN apt-get update -y \
    && apt-get install python3-pip wget -y \
    && pip3 install chaperone 
RUN wget https://www.percona.com/downloads/pmm-client/LATEST/pmm-client_${PMM_VERSION}_amd64.deb
RUN dpkg -i pmm-client_${PMM_VERSION}_amd64.deb

RUN mkdir -p /etc/chaperone.d

CMD ["/usr/local/bin/chaperone"]
