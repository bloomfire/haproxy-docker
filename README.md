Run a single instance of this haproxy container on a host machine, and it will load balance to all other web containers running on the same host.  It is fully automated so that as you add additional web containers or stop old ones, haproxy is updated accordingly.

Usage:

      docker run -v /var/run/docker.sock:/var/run/docker.sock \
                 -p 8080:8080 -p 4343:4343 bloomfire/haproxy

OR if you want a custom haproxy.cfg template:

      docker run -v /var/run/docker.sock:/var/run/docker.sock \\
                 -v /some/local/haproxy.tmpl:/etc/haproxy/haproxy.tmpl \\        
                 -p 80:80 bloomfire/haproxy

The haproxy.tmpl file is processed by [docker-gen][1] and is written as a golang template.


  [1]: https://github.com/jwilder/docker-gen
