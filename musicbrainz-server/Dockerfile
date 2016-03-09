############################################
# Dockerfile to build musicbrainz containers
# Based on Ubuntu 15.10
############################################

# Set the base image to Ubuntu
FROM ubuntu:15.10

# File Author / Maintainer
MAINTAINER Rick White

# Add extra repos
RUN sed -i -e "s/^# deb\(.*multiverse$\)/deb\1/g" /etc/apt/sources.list
RUN echo "deb http://cz.archive.ubuntu.com/ubuntu wily main multiverse" >> /etc/apt/sources.list

# Configure apt-get proxy
#RUN echo 'Acquire::http::Proxy "http://PROXY";' >> /etc/apt/apt.conf

# Install system dependencies
RUN apt-get update && \
apt-get install -y adduser sudo git unzip unrar curl \
bash-completion wget vim memcached redis-server \
build-essential nodejs npm nodejs-legacy libwww-perl \
libxml2-dev libpq-dev libexpat1-dev libdb-dev \
libicu-dev liblocal-lib-perl cpanminus libjson-xs-perl \
postgresql-client-9.4 && \
apt-get clean autoclean && \
apt-get autoremove -y && \
rm -rf /var/lib/{apt,dpkg,cache,log}/

# Install MusicBrainz
RUN mkdir -p /opt/musicbrainz
WORKDIR /opt/musicbrainz
RUN git clone --recursive git://github.com/metabrainz/musicbrainz-server.git .
RUN git checkout tags/v-2016-03-07

# Install perl dependencies
RUN echo 'eval $( perl -Mlocal::lib )' >> ~/.bashrc
#RUN http_proxy=http://PROXY cpanm --installdeps --notest .
RUN cpanm SARTAK/MooseX-Role-Parameterized-1.02.tar.gz

# Install nodejs dependencies
RUN npm install

# Add MusicBrainz config
ADD DBDefs.pm /opt/musicbrainz/lib/

# Build JavaScript/CSS
RUN ./script/compile_resources.sh

# Add scripts
ADD loaddb.sh /opt/musicbrainz/
ADD start.sh /opt/musicbrainz/
ADD updatedb.sh /opt/musicbrainz/

# Expose port
EXPOSE 5000
