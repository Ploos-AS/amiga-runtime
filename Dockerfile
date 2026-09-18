FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       coreutils \
       curl \
       file \
       fs-uae \
       jq \
       lhasa \
       libserialport0 \
       libportmidi0 \
       7zip \
       python3 \
       unzip \
       xauth \
       xorriso \
       xvfb \
    && rm -rf /var/lib/apt/lists/*

COPY bin/amiga-runtime /usr/local/bin/amiga-runtime
COPY bin/prepare-aros /usr/local/bin/prepare-aros
COPY bin/prepare-amiberry /usr/local/bin/prepare-amiberry
COPY bin/prepare-aros-guest-marker /usr/local/bin/prepare-aros-guest-marker
COPY bin/run-aros /usr/local/bin/run-aros
COPY bin/qualify-aros-boot /usr/local/bin/qualify-aros-boot
COPY bin/qualify-aros-arexx /usr/local/bin/qualify-aros-arexx
COPY lib /opt/amiga-runtime/lib
COPY profiles /opt/amiga-runtime/profiles
COPY runtime /opt/amiga-runtime/runtime
COPY backends /opt/amiga-runtime/backends

RUN chmod 0755 /usr/local/bin/amiga-runtime /usr/local/bin/prepare-aros /usr/local/bin/prepare-amiberry /usr/local/bin/prepare-aros-guest-marker /usr/local/bin/run-aros /usr/local/bin/qualify-aros-boot /usr/local/bin/qualify-aros-arexx \
    && chmod 0755 /opt/amiga-runtime/backends/fs-uae/backend /opt/amiga-runtime/backends/fs-uae/qualify-aros-boot /opt/amiga-runtime/backends/fs-uae/run-aros /opt/amiga-runtime/backends/amiberry/backend \
    && ln -sf /opt/amiga-runtime/backends/fs-uae/backend /usr/local/bin/backend-fs-uae \
    && ln -sf /opt/amiga-runtime/backends/amiberry/backend /usr/local/bin/backend-amiberry \
    && ln -sf /opt/amiga-runtime/backends/fs-uae/qualify-aros-boot /usr/local/bin/qualify-aros-boot-fs-uae \
    && ln -sf /opt/amiga-runtime/backends/fs-uae/run-aros /usr/local/bin/run-aros-fs-uae \
    && mkdir -p /opt/amiga-runtime/aros /work/input /work/evidence

ENV AMIBERRY_RUNTIME_DIR=/opt/amiga-runtime/amiberry
WORKDIR /work
ENTRYPOINT ["amiga-runtime"]
CMD ["self-test"]
