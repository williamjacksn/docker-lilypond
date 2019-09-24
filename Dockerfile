FROM ubuntu:18.04

ARG DEBIAN_FRONTEND="noninteractive"
RUN /usr/bin/apt-get update \
 && /usr/bin/apt-get install --assume-yes lilypond \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/lilypond"]
