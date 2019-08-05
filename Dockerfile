FROM alpine:3.10 as builder

RUN addgroup -g 1000 elasticsearch \
    && adduser -u 1000 -h /usr/share/elasticsearch -G elasticsearch elasticsearch -D \
    && apk add --no-cache bash gnupg openjdk11-jre-headless su-exec

FROM alpine:3.10

ENV OSBUILDER_CONTAINER true

COPY files/bootstrap.sh /tmp/bootstrap.sh
ENV VERSION 7.2.1
ENV GPG_KEY 46095ACC8548582C1A2699A9D27D666CD88E42B4
ENV DOWNLOAD_URL https://artifacts.elastic.co/downloads/elasticsearch
ENV EXPECTED_SHA_URL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.2.1-linux-x86_64.tar.gz.sha512
ENV ES_TARBALL_SHA fa7a3108cc67e09393aea625027e9c3777774994c634d183447900d6e5e420b244319935f9bad43094d6d3ad9f175e5e2065643bf0e2663c6300c99aaf4ab9b0
ENV ES_TARBAL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.2.1-linux-x86_64.tar.gz
ENV ES_TARBALL_ASC https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.2.1-linux-x86_64.tar.gz.asc
RUN ["/tmp/bootstrap.sh"]
RUN apk del --purge .build-deps
