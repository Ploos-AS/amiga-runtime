FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates \
       fs-uae \
       jq \
       python3 \
    && rm -rf /var/lib/apt/lists/*

COPY bin/amiga-runtime /usr/local/bin/amiga-runtime
COPY profiles /opt/amiga-runtime/profiles

RUN chmod 0755 /usr/local/bin/amiga-runtime \
    && mkdir -p /work/input /work/evidence

WORKDIR /work
ENTRYPOINT ["amiga-runtime"]
CMD ["self-test"]
