FROM phusion/baseimage:0.9.15

MAINTAINER David McCullars <dmccullars@bloomfire.com>

ADD etc/apt /etc/apt
RUN apt-get update -y && \
    apt-get install -y haproxy

ENV DOCKER_GEN_VERSION 0.3.6

RUN curl -L https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
  | tar -C /usr/local/bin -xz \
 && chown root:root /usr/local/bin/docker-gen

ADD etc /etc

EXPOSE 4343 8080
