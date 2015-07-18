#!/bin/bash

# Start postgres
sudo -u postgres /usr/lib/postgresql/9.4/bin/pg_ctl -D /var/lib/postgresql -l /var/lib/postgresql/postgres.log start
sleep 2

# Create database and user
sudo -u postgres psql --command "CREATE USER musicbrainz WITH SUPERUSER PASSWORD 'musicbrainz';"

# Stop postgres
sudo -u postgres /usr/lib/postgresql/9.4/bin/pg_ctl -D /var/lib/postgresql -l /var/lib/postgresql/postgres.log stop
