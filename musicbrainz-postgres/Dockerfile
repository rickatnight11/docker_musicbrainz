############################################
# Dockerfile to build musicbrainz containers
# Based on Ubuntu 14.10
############################################

# Set the base image to Ubuntu
FROM ubuntu:14.10

# File Author / Maintainer
MAINTAINER Rick White <rickatnight11@gmail.com>

# Add extra repos
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ utopic universe multiverse" >> /etc/apt/sources.list

# Configure apt-get proxy
#RUN echo 'Acquire::http::Proxy "http://hostname:port";' >> /etc/apt/apt.conf

# Install system dependencies
RUN apt-get update && \
apt-get install -y adduser sudo git unzip unrar \
bash-completion wget vim build-essential \
postgresql-9.4 postgresql-server-dev-9.4 \
postgresql-contrib-9.4 postgresql-plperl-9.4 \
libjson-xs-perl libicu-dev && \
apt-get clean autoclean && \
apt-get autoremove -y && \
rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
rm -rf /var/lib/postgresql

# Install MusicBrainz
RUN mkdir -p /opt/musicbrainz
WORKDIR /opt/muzicbrainz
RUN git clone git://github.com/metabrainz/postgresql-musicbrainz-unaccent.git
RUN git clone git://github.com/metabrainz/postgresql-musicbrainz-collate.git
WORKDIR /opt/muzicbrainz/postgresql-musicbrainz-unaccent
RUN make && make install
WORKDIR /opt/muzicbrainz/postgresql-musicbrainz-collate
RUN make && make install

# Configure postgres
EXPOSE 5432

# Add scripts
WORKDIR /
ADD initdb.sh /
ADD createuser.sh /
ADD startdb.sh /
