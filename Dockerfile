FROM ubuntu:latest
MAINTAINER Markus Rainer <markus.rainer@nts.eu>

COPY ./init.sh /opt/init.sh
COPY ./snx_install.sh /tmp/snx_install.sh

USER root
RUN mkdir /root/.ssh 
RUN chmod +x /opt/init.sh
RUN dpkg --add-architecture i386 \ 
    apt-get update \
    && apt-get install -y \
    openssh-server \
    libx11-6:i386 \
    libstdc++5:i386 \
    libpam0g:i386 \
    net-tools \
    netcat \
    dnsutils \
    iputils-ping \
    vim \
    && apt-get clean \
    && apt-get autoremove

RUN sh /tmp/snx_install.sh

ENV GATEWAY 127.0.0.1
ENV USERNAME user
ENV PASSWORD changeme

EXPOSE 22
VOLUME ["/root/.ssh"]

#ENTRYPOINT [ "/opt/init.sh" ]
