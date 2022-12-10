FROM php:8.0-apache-bullseye
COPY src/ /var/www/html/

ARG MEMCACHIER_SERVERS
ARG MEMCACHIER_USERNAME
ARG MEMCACHIER_PASSWORD

ENV MEMCACHIER_SERVERS $MEMCACHIER_SERVERS
ENV MEMCACHIER_USERNAME $MEMCACHIER_USERNAME
ENV MEMCACHIER_PASSWORD $MEMCACHIER_PASSWORD

RUN apt-get update && \
    apt-get install -y zlib1g-dev && \
    apt-get install -y libsasl2-modules && \
    apt-get install -y libmemcached-dev && \
    printf "\n" | pecl install memcached && \
    # docker-php-ext-enable memcached && \
    echo "extension=memcached.so" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "session.save_handler=memcached" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "session.save_path=$MEMCACHIER_SERVERS" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.sess_binary_protocol=On" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.sess_sasl_username=$MEMCACHIER_USERNAME" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.sess_sasl_password=$MEMCACHIER_PASSWORD" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.sess_persistent=On" >> /usr/local/etc/php/conf.d/20_memcached.ini
