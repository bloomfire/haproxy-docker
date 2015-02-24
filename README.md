Run a single instance of this haproxy container on a host machine, and it will load balance to all other web containers running on the same host.
Rather than be fully automated -- which could be too "grabby" and add new containers before they have finished starting up -- this requires an
exec into the container to notify it that it should regenerate the haproxy config based on running containers.

Usage:

      docker run -v /var/run/docker.sock:/var/run/docker.sock \
                 -p 8080:8080 -p 4343:4343 bloomfire/haproxy

OR if you want a custom haproxy.cfg template:

      docker run -v /var/run/docker.sock:/var/run/docker.sock \\
                 -v /some/local/haproxy.tmpl:/etc/haproxy/haproxy.tmpl \\        
                 -p 80:80 bloomfire/haproxy

The haproxy.tmpl file is processed by [docker-gen][1] and is written as a golang template.

  [1]: https://github.com/jwilder/docker-gen

To notify the haproxy container to regenerate its config execute:

      docker exec HAPROXY_CONTAINER_ID haproxy-gen
