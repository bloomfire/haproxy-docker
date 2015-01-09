#!/bin/bash

if [ ! -S /var/run/docker.sock ]; then

  >&2 cat << DONE

###############################################################"
The haproxy container needs the host docker.sock
Usage:

  docker run -v /var/run/docker.sock:/var/run/docker.sock \\
             -p 8080:8080 -p 4343:4343 bloomfire/haproxy

###############################################################

DONE

  exit 1

fi
