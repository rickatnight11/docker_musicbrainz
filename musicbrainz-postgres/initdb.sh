#!/bin/bash

# Change database ownership to posgres
chown postgres:postgres /var/lib/postgresql

# Initialize database
sudo -u postgres /usr/lib/postgresql/9.4/bin/initdb -D /var/lib/postgresql

# Configure database
sudo -u postgres echo "listen_addresses='*'" >> /var/lib/postgresql/postgresql.conf
sudo -u postgres  echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/pg_hba.conf
