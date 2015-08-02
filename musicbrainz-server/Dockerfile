############################################
# Dockerfile to build musicbrainz containers
# Based on Ubuntu 14.10
############################################

# Set the base image to Ubuntu
FROM musicbrainz:002

# File Author / Maintainer
MAINTAINER Rick White <rickatnight11@gmail.com>

RUN mkdir -p /opt/musicbrainz

WORKDIR /opt/musicbrainz

#RUN apt-get update && apt-get install -y \
#	memcached redis-server build-essential \
#	nodejs npm nodejs-legacy git-core \
#	cpanminus liblocal-lib-perl \
#	libxml2-dev libpq-dev libexpat1-dev \
#	libdb-dev libicu-dev nginx perl

#RUN git clone --recursive git://github.com/metabrainz/musicbrainz-server.git . && \
#	git fetch --tags && \
#	git checkout $(git describe --tags)

COPY DBDefs.pm lib/DBDefs.pm

COPY cpanfile /opt/musicbrainz/cpanfile

#RUN cpanm --installdeps --notest .

RUN npm install && ./node_modules/.bin/gulp

# Add scripts
ADD startmb.sh /opt/musicbrainz/
ADD updatedb.sh /opt/musicbrainz/
