FROM ubuntu:18.04

ARG DEBIAN_FRONTEND="noninteractive"

ENV LILYPOND_VERSION="2.18.2-12build1"

RUN /usr/bin/apt-get update \
 && /usr/bin/apt-get dist-upgrade --assume-yes \
 && /usr/bin/apt-get install --assume-yes "lilypond=${LILYPOND_VERSION}" \
 && /usr/bin/apt-get autoremove --assume-yes \
 && /usr/bin/apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/lilypond"]
