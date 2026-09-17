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
       7zip \
       python3 \
       unzip \
       xauth \
       xorriso \
       xvfb \
    && rm -rf /var/lib/apt/lists/*

COPY bin/amiga-runtime /usr/local/bin/amiga-runtime
COPY bin/prepare-aros /usr/local/bin/prepare-aros
COPY bin/prepare-aros-guest-marker /usr/local/bin/prepare-aros-guest-marker
COPY bin/run-aros /usr/local/bin/run-aros
COPY bin/qualify-aros-boot /usr/local/bin/qualify-aros-boot
COPY lib /opt/amiga-runtime/lib
COPY profiles /opt/amiga-runtime/profiles
COPY runtime /opt/amiga-runtime/runtime

RUN chmod 0755 /usr/local/bin/amiga-runtime /usr/local/bin/prepare-aros /usr/local/bin/prepare-aros-guest-marker /usr/local/bin/run-aros /usr/local/bin/qualify-aros-boot \
    && mkdir -p /opt/amiga-runtime/aros /work/input /work/evidence

WORKDIR /work
ENTRYPOINT ["amiga-runtime"]
CMD ["self-test"]
