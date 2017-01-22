# SKS Key Server Web UI

## Intro

This is the [Nginx](http://nginx.org) web front end for the
[SKS OpenPGP Keyserver](https://bitbucket.org/skskeyserver/sks-keyserver) using
[Alpine Linux Project](http://alpinelinux.org).

## Guide

This container has a volume which is `/etc/ssl` inside to locate appropriate
SSL certificates, keys and DH parameter files. Please mount it from a
persistent storage source.

### Setup

Current build configuration assumes use of Docker swarm mode to utilize the
mesh routing DNS to locate the SKS key servers to proxy to.

Current build configuration looks for a `sks` service to have been created and
deployed to the swarm overlay network.

```
docker network create --driver overlay --subnet 10.0.9.0/24 my-network

docker service create --name sks --network my-network --publish 11370:11370 \
  --mount type=volume,src=sks-data,dst=/var/lib/sks,volume-driver=local \
  jtbouse/sks
```

Deployment uses the Docker engine host's `/etc/ssl` directory contents as a
read-only bind volume mount which requires the SSL certificates to be deployed
under `/etc/ssl/certs`, the SSL certficate key to be deployed under
`/etc/ssl/private` and a DH parameters file deployed as `/etc/ssl/dhparams.pem`.

### Run 

```
docker service create --name nginx --network my-network --publish 80:80 \
  --publish 443:443 --publish 11371:11371 --mount \
  type=bind,src=/etc/ssl,dst=/etc/ssl,readonly jtbouse/sks-nginx
```

Configuration is setup to serve static content from `/usr/share/nginx/html` and
reverse proxy server for `/pks` location URIs back to
`http://sks:11371` using Docker swarm service VIP.

### References

Web template modified from [mattrude/pgpkeyserver-lite](https://github.com/mattrude/pgpkeyserver-lite)

Containers:
- [jtbouse/sks](http://hub.docker.com/r/jtbousej/sks) SKS OpenPGP Keyserver
- [nginx:alpine](http://hub.docker.com/_/nginx) Nginx on Alpine Linux

Live demo: [UnderGrid Network Service Key Server](http://sks.undergrid.net:11371)