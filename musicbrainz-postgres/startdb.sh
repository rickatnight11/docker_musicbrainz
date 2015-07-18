#!/bin/bash

# Start postgres
sudo -u postgres /usr/lib/postgresql/9.4/bin/pg_ctl -D /var/lib/postgresql -l /var/lib/postgresql/postgres.log start
sleep 2
tail -f /var/lib/postgresql/postgres.log
