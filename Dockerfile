FROM php:8.0-apache-bullseye
COPY src/ /var/www/html/

ARG MEMCACHIER_SERVERS
ARG MEMCACHIER_USERNAME
ARG MEMCACHIER_PASSWORD

ENV MEMCACHIER_SERVERS $MEMCACHIER_SERVERS
ENV MEMCACHIER_USERNAME $MEMCACHIER_USERNAME
ENV MEMCACHIER_PASSWORD $MEMCACHIER_PASSWORD
ENV ENABLE_SASL ON

RUN apt-get update && \
    apt-get install -y make cmake flex bison && \
    apt-get install -y zlib1g-dev && \
    apt-get install -y libsasl2-dev && \
    apt-get install -y libsasl2-modules && \
    curl -L  https://github.com/memcachier/awesomized-libmemcached/tarball/fix-sasl-uninitialized-buffer -o libmemcached.tgz && \
    mkdir -p /tmp/libmemcached && \
    tar -xf libmemcached.tgz -C /tmp/libmemcached --strip-components=1 && \
    rm libmemcached.tgz && \
    mkdir /tmp/build-libmemcached && \
    cd /tmp/build-libmemcached && \
    export ENABLE_SASL=ON && \
    cmake ../libmemcached && \
    make && \
    make install && \
    rm -r /tmp/build-libmemcached && \
    rm -r /tmp/libmemcached && \
    # printf "\n" | pecl install --configureoptions "enable-memcached-sasl='no'" memcached && \
    printf "\n" | pecl install igbinary && \
    docker-php-ext-enable igbinary && \
    printf "\n" | pecl install --configureoptions "enable-memcached-igbinary='yes'" memcached && \
    docker-php-ext-enable memcached && \
    # echo "extension=memcached.so" > /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "session.save_handler=memcached" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "session.save_path=$MEMCACHIER_SERVERS" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.sess_binary_protocol=On" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.sess_locking=Off" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.default_binary_protocol=On" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.sess_sasl_username=$MEMCACHIER_USERNAME" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.sess_sasl_password=$MEMCACHIER_PASSWORD" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
    echo "memcached.sess_persistent=On" >> /usr/local/etc/php/conf.d/20_memcached.ini

# RUN apt-get update && \
#     apt-get install -y gcc make autoconf libc-dev pkg-config && \
#     apt-get install -y zlib1g-dev && \
#     apt-get install -y libmemcached-dev && \
#     printf "\n" | pecl install memcached && \
#     echo "extension=memcached.so" > /usr/local/etc/php/conf.d/20_memcached.ini && \
#     echo "session.save_handler=memcached" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
#     echo "session.save_path=$MEMCACHIER_SERVERS:11211" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
#     echo "memcached.sess_binary_protocol=On" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
#     echo "memcached.sess_sasl_username=$MEMCACHIER_USERNAME" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
#     echo "memcached.sess_sasl_password=$MEMCACHIER_PASSWORD" >> /usr/local/etc/php/conf.d/20_memcached.ini && \
#     echo "memcached.sess_persistent=On" >> /usr/local/etc/php/conf.d/20_memcached.ini