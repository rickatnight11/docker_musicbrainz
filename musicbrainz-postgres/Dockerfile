FROM musicbrainz-postgres:0.0.1

MAINTAINER Ivan Suftin <isuftin@gmail.com>

WORKDIR /tmp

#COPY /scripts/DBDefs.pm DBDefs.pm

#COPY /scripts/initscript.sh initscript.sh

#RUN chmod a+x initscript.sh; sleep 1; /tmp/initscript.sh

#COPY /scripts/init-database.sh /docker-entrypoint-initdb.d/

COPY cpanfile /tmp/cpanfile
RUN apt-get install -y cpanminus && cpanm Module::CPANfile

RUN cpanm --installdeps  --notest .

VOLUME ["/dump"]
