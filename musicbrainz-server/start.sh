#!/bin/bash

# Start Redis
/etc/init.d/redis-server start

# Start Memcached
/etc/init.d/memcached start

# Start Musicbrainz
plackup -Ilib -r
