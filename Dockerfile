FROM ubuntu:22.04

RUN echo "Welcome on WeScale CTF. Challenge 17" && \
    dpkg --print-architecture && \
    apt-get update && \
    apt-get install -y python3

RUN --mount=type=secret,id=wescale_flag \
    cat /run/secrets/wescale_flag > /flag.txt && \
    chown root:root /flag.txt && \
    chmod 600 /flag.txt
    
RUN --mount=type=secret,id=docker_token \
    cat /run/secrets/docker_token > /tmp/docker_token

RUN mkdir -p /etc/docker/ && \
    echo '{"auths":{"ghcr.io":{"auth":"%DOCKER_AUTH%"}}}' > /etc/docker/config.json && \
    sed "s/%DOCKER_AUTH%/$(cat /tmp/docker_token | base64)/g" /etc/docker/config.json | base64 && \
    rm -rf \
        /tmp/docker_token \
        /usr/bin/bash \
        /usr/bin/zsh \
        /usr/bin/sh \
        /usr/bin/ash \
        /usr/bin/cat \
        /usr/bin/echo \
        /usr/bin/apt*

USER 1001

ENTRYPOINT ["/usr/bin/python3"]
