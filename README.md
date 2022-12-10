# README

This repo contains a Dockerfile for installing the `memcached` PHP PECL, with SASL enabled, and sessions configured with MemCachier.

It was used to troubleshoot an error with sessions working:

> Warning: session_start(): Failed to write session lock: FAILED TO SEND AUTHENTICATION TO SERVER
>
> Warning: session_start(): Failed to write session lock: SERVER HAS FAILED AND IS DISABLED UNTIL TIMED RETRY

## Solution

Turns out the `libsasl2-modules` module was required.

## Helpful commands

```bash
docker build --progress=plain --no-cache --build-arg MEMCACHIER_USERNAME=<username> --build-arg MEMCACHIER_PASSWORD=<password> --build-arg MEMCACHIER_SERVERS=<server:port> -t my-php-app .

docker run -d -p 8080:80 --name my-running-app my-php-app

# SSH into container
docker exec -it my-running-app /bin/sh

docker stop my-running-app && docker rm my-running-app

# Check memcached PHP extension config (e.g. if SASL enabled)
php --ri memcached
```
