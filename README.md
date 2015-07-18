# Docker MusicBrainz
Instructions for building and running MusicBrainz in Docker containers

Features
--------
* Ubuntu 14.10 base
* Full MusicBrainz web/API mirror (current tag: **v-2015-07-13**)
* Helper scripts (start, initialize/seed/update DB, etc)
* Optional HTTP mirror support
* Optional tuned Postgres container

To Do
-----
* MusicBrainz Lucene search mirror container
* Base `musicbrainz-postgres` container off of [official Postgres container](https://registry.hub.docker.com/_/postgres/)

Instructions
------------
1. Provision Postgres server according to the [MusicBrainz project's instructions](https://github.com/metabrainz/musicbrainz-server/blob/master/INSTALL.md) or by building the included `musicbrainz-postgres` container (instructions [here](musicbrainz-postgres/README.md)).
2. Build and run `musicbrainz-server` container (instructions [here](musicbrainz-server/README.md)).
