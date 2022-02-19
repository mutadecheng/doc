FROM alpine

LABEL org.opencontainers.image.url="https://gitlab.com/Lukas1818/docker-mjpg-streamer/container_registry"
LABEL org.opencontainers.image.title="stream webcam or copy JPEG frames from one or more input plugins to multiple output plugins"
LABEL org.opencontainers.image.source="https://gitlab.com/Lukas1818/docker-mjpg-streamer"

RUN set -xe \
    && echo "@edge https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --no-cache mjpg-streamer@edge

ENTRYPOINT  ["mjpg_streamer"]
