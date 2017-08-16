#!/bin/bash

if [ ! -S /var/run/docker.sock ]; then

  >&2 cat << DONE

###############################################################"
The haproxy container needs the host docker.sock
Usage:

  docker run -v /var/run/docker.sock:/var/run/docker.sock \\
             -p 80:80 bloomfire/haproxy

###############################################################

DONE

  exit 1

fi

runsvdir -P /etc/service &
PID=$!

echo "Starting Up ($PID) ..."
trap "echo 'Shutting Down ($PID) ...' && kill -SIGHUP $PID && exit 0" SIGTERM SIGINT SIGHUP

haproxy-gen

if [ -e /var/run/container-change ]; then
  inotifywait -q -m -e attrib --format '%w%f' /var/run/container-change | while read NEWFILE
  do
    sleep 1 # Give it some time for the container to be fully up or down
    haproxy-gen
  done
fi

wait $PID
