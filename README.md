Run a single instance of this haproxy container on a host machine, and it will load balance to all other web containers running on the same host.
There are two ways for new containers to notify haproxy that it should add the new container to the server pool.  One way is by adding volumes from
the haproxy container and then touching the directory /var/run/container-change.  The other way is to exec into the container and manually run
haproxy-gen.

Usage:

      docker run -v /var/run/docker.sock:/var/run/docker.sock \
                 -p 80 bloomfire/haproxy

OR if you want a custom haproxy.cfg template:

      docker run -v /var/run/docker.sock:/var/run/docker.sock \\
                 -v /some/local/haproxy.tmpl:/etc/haproxy/haproxy.tmpl \\        
                 -p 80:80 bloomfire/haproxy

The haproxy.tmpl file is processed by [docker-gen][1] and is written as a golang template.

  [1]: https://github.com/jwilder/docker-gen

To notify the haproxy container to regenerate its config execute:

      docker exec HAPROXY_CONTAINER_ID haproxy-gen
