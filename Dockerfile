FROM ubuntu
MAINTAINER grunwald@cs.colorado.edu

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl \
    python-pip

RUN  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN  curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
     && curl -o /usr/local/bin/gosu.asc \
     	-SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
     && gpg --verify /usr/local/bin/gosu.asc \
     && rm /usr/local/bin/gosu.asc \
     && chmod +x /usr/local/bin/gosu

RUN mkdir -p /opt /run && \
    pip install --upgrade pip && \
    pip install setuptools && \
    pip install runestone 

VOLUME /opt
WORKDIR /opt

EXPOSE 8000

ADD  imagefiles-build/entrypoint.sh /run

CMD [ "/bin/bash", "/run/entrypoint.sh" ]

