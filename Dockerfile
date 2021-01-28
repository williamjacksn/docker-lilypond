FROM ubuntu:20.04

ARG DEBIAN_FRONTEND="noninteractive"
ARG LILYPOND_VERSION="2.22.0-1"

RUN /usr/bin/apt-get update \
 && /usr/bin/apt-get dist-upgrade --assume-yes \
 && /usr/bin/apt-get install --assume-yes curl \
 && /usr/bin/curl --location --remote-name --url "http://lilypond.org/download/binaries/linux-64/lilypond-${LILYPOND_VERSION}.linux-64.sh" \
 && /bin/sh "/lilypond-${LILYPOND_VERSION}.linux-64.sh" --batch \
 && /usr/bin/apt-get purge --assume-yes curl \
 && /usr/bin/apt-get autoremove --assume-yes \
 && /usr/bin/apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/lilypond"]
