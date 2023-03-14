FROM python:3.11.2-slim-bullseye

ARG DEBIAN_FRONTEND="noninteractive"
ARG LILYPOND_VERSION="2.24.1"

RUN /usr/bin/apt-get update \
 && /usr/bin/apt-get dist-upgrade --assume-yes \
 && /usr/bin/apt-get install --assume-yes curl \
 && /usr/bin/curl --location --remote-name --url "https://gitlab.com/lilypond/lilypond/-/releases/v${LILYPOND_VERSION}/downloads/lilypond-${LILYPOND_VERSION}-linux-x86_64.tar.gz" \
 && /bin/tar --extract --file="lilypond-${LILYPOND_VERSION}-linux-x86_64.tar.gz" \
 && /bin/mv "/lilypond-${LILYPOND_VERSION}" "/lilypond" \
 && /usr/bin/apt-get purge --assume-yes curl \
 && /usr/bin/apt-get autoremove --assume-yes \
 && /usr/bin/apt-get clean \
 && /bin/rm --force --recursive /var/lib/apt/lists/* "lilypond-${LILYPOND_VERSION}-linux-x86_64.tar.gz"

RUN /usr/sbin/useradd --create-home --shell /bin/bash --user-group python

USER python
RUN /usr/local/bin/python -m venv /home/python/venv

COPY requirements.txt /home/python/docker-lilypond/requirements.txt
RUN /home/python/venv/bin/pip install --no-cache-dir --requirement /home/python/docker-lilypond/requirements.txt

ENV PATH="/home/python/venv/bin:/lilypond/bin:${PATH}" \
    PYTHONDONTWRITEBYTECODE="1" \
    PYTHONUNBUFFERED="1" \
    TZ="Etc/UTC"

RUN ["/lilypond/bin/lilypond", "--version"]

ENTRYPOINT ["/lilypond/bin/lilypond"]
