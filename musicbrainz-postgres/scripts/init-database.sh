#!/bin/bash -e

export PGHOST=localhost
export PGPORT=5432
export PGDATABASE=template1
export PGUSER=$POSTGRES_USER
export PGPASSWORD=$POSTGRES_PASSWORD
export PGPASSFILE=/.pgpass

init_clean=${init_clean:-false}

echo  "localhost:5432:$PGDATABASE:$POSTGRES_USER:$POSTGRES_PASSWORD" > /.pgpass
chmod 600  /.pgpass

gosu postgres postgres --single -j <<- EOSQL
    DROP DATABASE IF EXISTS musicbrainz;
EOSQL

gosu postgres postgres --single -j <<- EOSQL
    CREATE DATABASE template1 OWNER $PGUSER;
EOSQL

gosu postgres postgres --single -j <<- EOSQL
    CREATE DATABASE musicbrainz_test OWNER $PGUSER;
EOSQL

mv /tmp/DBDefs.pm /tmp/server/lib/

if $init_clean; then
	echo "Intantiating clean database..."
  	./admin/InitDb.pl --createdb --clean
  	echo "Fresh database instantiation complete!"
else
	if [[ -f /dump/mbdump.tar.bz2 && -f /dump/mbdump-editor.tar.bz2 && -f /dump/mbdump-derived.tar.bz2 ]]; then
  		echo "Database dump files exist"
	else
  		echo "Database dump files do not exist. Grabbing now"
  		apt-get install -y wget
  		LATEST=$(curl -si ftp://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/LATEST)
  		wget -O /dump -r --no-parent -nH --cut-dirs=5 ftp://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/$LATEST/ 
	fi
	gosu postgres pg_ctl -D /var/lib/postgresql/data -l /tmp/logfile start
	/tmp/server/admin/InitDb.pl --createdb --import /dump/mbdump*.tar.bz2 --echo
	gosu postgres pg_ctl -D /var/lib/postgresql/data -l /tmp/logfile stop
fi

gosu postgres postgres --single -j <<- EOSQL
    CREATE EXTENSION IF NOT EXISTS musicbrainz_collate;
EOSQL

gosu postgres postgres --single -j <<- EOSQL
    CREATE EXTENSION IF NOT EXISTS musicbrainz_unaccent;
EOSQL

gosu postgres postgres --single -j <<- EOSQL
    ALTER DATABASE musicbrainz SET statement_timeout to 60000;
EOSQL
