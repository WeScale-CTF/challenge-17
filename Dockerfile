FROM ubuntu:22.04

ARG WESCALE_FLAG
ARG DOCKER_TOKEN

RUN echo "Welcome on WeScale CTF. Challenge 17" && \
    echo "${WESCALE_FLAG}" > /flag.txt && \
    mkdir -p /etc/docker/ && \
    echo '{"auths":{"ghcr.io":{"auth":"%DOCKER_AUTH%"}}}' > /etc/docker/config.json && \
    sed "s/%DOCKER_AUTH%/$(echo ${DOCKER_TOKEN} | base64)/g" /etc/docker/config.json | base64 && \
    dpkg --print-architecture && \
    rm -rf /bin/{bash,zsh,sh,ash}

ENTRYPOINT ["echo", "Welcome on WeScale CTF. Challenge 17"]
