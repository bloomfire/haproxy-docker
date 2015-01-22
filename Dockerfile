FROM debian:jessie

MAINTAINER David McCullars <dmccullars@bloomfire.com>

ADD etc/apt /etc/apt
RUN apt-get update -y && \
    apt-get install -y \
            haproxy \
            runit

ENV DOCKER_GEN_VERSION 0.3.6
ADD https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    /tmp/docker-gen.tgz

RUN tar -C /usr/local/bin -xzf /tmp/docker-gen.tgz \
 && rm -f /tmp/docker-gen.tgz

EXPOSE 4343 8080

ADD bin /bin
ADD etc /etc

CMD ["/bin/start-services.sh"]
