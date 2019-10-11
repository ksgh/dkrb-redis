FROM kshenk/centos:7.7

RUN yum install -y make gcc && \
    mkdir /tmp-redis-install && \
    curl -s http://download.redis.io/redis-stable.tar.gz > /tmp-redis-install/redis-stable.tar.gz && \
    cd /tmp-redis-install && \
    tar -zxf redis-stable.tar.gz && \
    cd redis-stable && \
    make && \
    make install && \
    cd && \
    rm -rf /tmp-redis-install && \
    yum remove -y gcc make && \
    yum clean all

COPY ./src/redis.conf /etc/redis.conf

EXPOSE 6379
ENTRYPOINT ["/usr/local/bin/redis-server", "/etc/redis.conf"]
CMD []
