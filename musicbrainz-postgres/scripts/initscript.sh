#!/bin/bash -e

export DEBIAN_FRONTEND=noninteractive

echo "Installing required libs"
apt-get update
apt-get install -y \
    postgresql-contrib-9.4 \
    postgresql-server-dev-9.4 \
    postgresql-plperl-9.4 \
    git-core \
    libicu48 \
    libicu-dev \
    build-essential \
    cpanminus \
    libwww-perl \
    libxml2-dev \
    libpq-dev \
    libexpat1-dev \
    libdb-dev \
    libicu-dev \
    liblocal-lib-perl \
    libjson-xs-perl 

echo "Cloning MusicBrainz repos for installation"
rm -rf /tmp/unaccent && rm -rf /tmp/collate && rm -rf /tmp/server
git clone https://github.com/metabrainz/postgresql-musicbrainz-unaccent.git /tmp/unaccent
git clone https://github.com/metabrainz/postgresql-musicbrainz-collate.git /tmp/collate
git clone https://github.com/metabrainz/musicbrainz-server.git /tmp/server

echo "Compiling db dependencies"
cd /tmp/unaccent && make && make install && rm -rf /tmp/unaccent
cd /tmp/collate && make && make install && rm -rf /tmp/collate

cd /tmp

chmod a+x /tmp/cpan-deps.sh && sleep 1 && source /tmp/cpan-deps.sh

apt-get clean autoclean
apt-get autoremove -y
