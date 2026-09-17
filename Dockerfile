FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       coreutils \
       curl \
       fs-uae \
       jq \
       python3 \
       unzip \
       xorriso \
       xvfb \
    && rm -rf /var/lib/apt/lists/*

COPY bin/amiga-runtime /usr/local/bin/amiga-runtime
COPY bin/prepare-aros /usr/local/bin/prepare-aros
COPY bin/run-aros /usr/local/bin/run-aros
COPY bin/qualify-aros-boot /usr/local/bin/qualify-aros-boot
COPY lib /opt/amiga-runtime/lib
COPY profiles /opt/amiga-runtime/profiles
COPY runtime /opt/amiga-runtime/runtime

RUN chmod 0755 /usr/local/bin/amiga-runtime /usr/local/bin/prepare-aros /usr/local/bin/run-aros /usr/local/bin/qualify-aros-boot \
    && mkdir -p /opt/amiga-runtime/aros /work/input /work/evidence

WORKDIR /work
ENTRYPOINT ["amiga-runtime"]
CMD ["self-test"]
