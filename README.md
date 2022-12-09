# README

```bash
docker build --no-cache --build-arg MEMCACHIER_USERNAME=<username> --build-arg MEMCACHIER_PASSWORD=<password> --build-arg MEMCACHIER_SERVERS=<server:port> -t my-php-app .

docker run -d -p 8080:80 --name my-running-app my-php-app

docker exec -it my-running-app /bin/sh

docker stop my-running-app && docker rm my-running-app
```
