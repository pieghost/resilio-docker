FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteracive

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y ca-certificates curl zip && \
    apt-get clean && \
    curl -sSL https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz | tar xz -C /usr/bin/ rslsync && \
    apt-get purge -y --auto-remove curl && \
    rm -rf /var/lib/apt/lists/*

ENV STORAGE_PATH /data/system
ENV DIRECTORY_ROOT /data/storage

COPY config.json /etc/rslsync.conf
COPY run /

EXPOSE 8888 55555

VOLUME /data

ENTRYPOINT ["/run"]
CMD ["--nodaemon", "--log", "--config", "/etc/rslsync.conf"]

