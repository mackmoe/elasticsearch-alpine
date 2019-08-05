#!/bin/sh
#####
# This ENV should already be set before this is run but just check to make sure.
#
#####


check_workdir() {
if [ ! $PWD = "/tmp" ]; then
  set -ex
  cd /tmp
  echo -e "===> Install Elasticsearch..."
else
  set -ex
  echo -e "===> Install Elasticsearch..."
fi
}

version_check() {
if [ "$ES_TARBALL_SHA" ]; then
  echo "$ES_TARBALL_SHA *elasticsearch.tar.gz" | sha512sum -c -
fi
}

add_gpgkeys() {
if [ "$ES_TARBALL_ASC" ]; then
  wget -nv -O elasticsearch.tar.gz.asc "$ES_TARBALL_ASC"
  export GNUPGHOME="$(mktemp -d)"
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" || \
  gpg --keyserver pgp.mit.edu --recv-keys "$GPG_KEY" ||  \
  gpg --keyserver keyserver.pgp.com --recv-keys "$GPG_KEY" || \
  gpg --batch --verify elasticsearch.tar.gz.asc elasticsearch.tar.gz
  rm -rf "$GNUPGHOME" elasticsearch.tar.gz.asc || true
fi
}

create_directory_structure() {
  echo "===> Creating Elasticsearch Paths..."
  for path in /usr/share/elasticsearch/data /usr/share/elasticsearch/logs /usr/share/elasticsearch/config /usr/share/elasticsearch/config/scripts /usr/share/elasticsearch/tmp /usr/share/elasticsearch/plugins; do
    mkdir -p "$path";
    chown -R elasticsearch:elasticsearch "$path";
  done
}

untar_elastic() {
  tar -xf elasticsearch.tar.gz
  ls -lah
  mv elasticsearch-$VERSION /usr/share/elasticsearch
}

check_workdir
wget -nv -O elasticsearch.tar.gz "$ES_TARBAL"
version_check
add_gpgkeys
untar_elastic
create_directory_structure
rm -rf /tmp/* /usr/share/elasticsearch/jdk
