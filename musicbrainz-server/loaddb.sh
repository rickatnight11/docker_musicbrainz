#!/bin/bash

set -e

# Instantiate clean DB
if [ "$1" = "--clean" ]
then
  echo "Intantiating clean database..."
  cd /opt/musicbrainz/
  ./admin/InitDb.pl --createdb --clean
  echo "Fresh database instantiation complete!"

# Download and import latest DB dump
else
  echo "Downloading latest DB dump..."
  LATEST="$(curl -si ftp://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/LATEST)"
  echo "Latest DB dump found: $LATEST"

  # Download contents of latest dump folder
  curl -s ftp://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/${LATEST}/ | \
    grep -e '^-' | awk '{ print $9 }' | \
      while read f; do \
        FILE="ftp://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/${LATEST}/$f"; \
        echo "Downloading ${FILE}..."; \
        curl --create-dirs -o "/tmp/${LATEST}/${f}" -C - ${FILE}; \
      done
  
  # Verify data integrity
  pushd /tmp/${LATEST}/ && md5sum -c MD5SUMS && popd

  # Import database dumps
  cd /opt/musicbrainz/
  ./admin/InitDb.pl --createdb --import /tmp/${LATEST}/mbdump*.tar.bz2 --echo
  
fi
