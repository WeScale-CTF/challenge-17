FROM ubuntu:22.04

ARG WESCALE_FLAG
ARG DOCKER_TOKEN

RUN set -xe && \
    echo "Welcome on WeScale CTF. Challenge 17" && \
    apt-get update && \
    apt-get install -y python3 && \
    echo "${WESCALE_FLAG}" > /flag.txt && \
    mkdir -p /etc/docker/ && \
    echo '{"auths":{"ghcr.io":{"auth":"%DOCKER_AUTH%"}}}' > /etc/docker/config.json && \
    sed "s/%DOCKER_AUTH%/$(echo ${DOCKER_TOKEN} | base64)/g" /etc/docker/config.json | base64 && \
    dpkg --print-architecture && \
    chown root:root /flag.txt && \
    chmod 600 /flag.txt && \
    rm -rf /usr/bin/bash /usr/bin/zsh /usr/bin/sh /usr/bin/ash /usr/bin/cat /usr/bin/echo /usr/bin/apt*

USER 1001

ENTRYPOINT ["/usr/bin/python3"]
