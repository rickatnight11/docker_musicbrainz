FROM postgres:9.4.1

MAINTAINER Ivan Suftin <isuftin@gmail.com>

COPY /scripts/init-database.sh /docker-entrypoint-initdb.d/

COPY /scripts/initscript.sh /tmp/initscript.sh

COPY /scripts/DBDefs.pm /tmp/DBDefs.pm

COPY /scripts/cpan-deps.sh /tmp/cpan-deps.sh

VOLUME ["/dump"]

RUN chmod a+x /tmp/initscript.sh; sleep 1; /tmp/initscript.sh

