FROM debian:stretch
LABEL maintainer maxime@siliadev.com

ENV NETATALK_VERSION 3.1.11
ENV NETATALK_CHECKSUM 3434472ba96d3bbe3b024274438daad83b784ced720f7662a4c1d0a1078799a6

RUN set -x \
    && apt-get update \
    && apt-get install -y \
         build-essential \
         ca-certificates \
         autoconf \
         automake \
         autotools-dev \
         bash \
         curl \
         libevent-dev \
         libssl-dev \
         libgcrypt11-dev \
         libkrb5-dev \
         libpam0g-dev \
         libwrap0-dev \
         libdb-dev \
         libtdb-dev \
         libavahi-client-dev \
         libacl1-dev \
         libldap2-dev \
         libcrack2-dev \
         systemtap-sdt-dev \
         libdbus-1-dev \
         libdbus-glib-1-dev \
         libglib2.0-dev \
         libtracker-sparql-1.0-dev \
         libtracker-miner-1.0-dev \
         file \
         tracker \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L "https://downloads.sourceforge.net/project/netatalk/netatalk/${NETATALK_VERSION}/netatalk-${NETATALK_VERSION}.tar.bz2" \
         -o "/tmp/netatalk-${NETATALK_VERSION}.tar.bz2"

WORKDIR /tmp
RUN echo "${NETATALK_CHECKSUM} netatalk-${NETATALK_VERSION}.tar.bz2" \
      | sha256sum -c -

RUN tar xvfj "/tmp/netatalk-${NETATALK_VERSION}.tar.bz2"
WORKDIR /tmp/netatalk-${NETATALK_VERSION}
RUN ./configure \
       --prefix=/usr \
       --sysconfdir=/etc \
       --with-init-style=debian-systemd \
       --without-libevent \
       --without-tdb \
       --with-cracklib \
       --enable-krbV-uam \
       --with-pam-confdir=/etc/pam.d \
       --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
       --with-tracker-pkgconfig-version=1.0 \
    && make \
    && make install \
    && rm -rf /tmp/*

COPY entrypoint.sh /entrypoint.sh

WORKDIR /root
CMD /entrypoint.sh
