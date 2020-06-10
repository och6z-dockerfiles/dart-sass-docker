ARG DEBIAN_VERSION

FROM debian:${DEBIAN_VERSION}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    && apt-get purge -y && apt-get autoremove -y && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

ARG DARTSASS_VERSION
ARG DARTSASS_DOWNLOAD_URL=https://github.com/sass/dart-sass/releases/download/${DARTSASS_VERSION}/dart-sass-${DARTSASS_VERSION}-linux-x64.tar.gz
ENV DARTSASS_DOWNLOAD_URL ${DARTSASS_DOWNLOAD_URL}

RUN wget --output-document=dart-sass.tar.gz ${DARTSASS_DOWNLOAD_URL} \
    && mkdir --parents /usr/src/dart-sass \
    && tar -xzf dart-sass.tar.gz --directory=/usr/src/dart-sass --strip-components=1 \
    && rm dart-sass.tar.gz

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["/usr/src/dart-sass/sass"]
