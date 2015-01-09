FROM debian:jessie

MAINTAINER David McCullars <dmccullars@bloomfire.com>

ADD etc/apt /etc/apt
RUN apt-get update -y && \
    apt-get install -y \
            haproxy \
            runit \
            wget

ENV DOCKER_GEN_VERSION 0.3.6

RUN wget -O - https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
  | tar -C /usr/local/bin -xz \
 && chown root:root /usr/local/bin/docker-gen

RUN apt-get purge --auto-remove -y \
            wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/*

EXPOSE 4343 8080

ADD bin /bin
ADD etc /etc

CMD ["/bin/start-services.sh"]
