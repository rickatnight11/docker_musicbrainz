# Docker MusicBrainz
Instructions for building and running MusicBrainz in Docker containers

Features
--------
* Ubuntu 14.10 base
* Full MusicBrainz web/API mirror
* Helper scripts (start, initialize/seed/update DB, etc)
* Optional HTTP mirror support
* Optional tuned Postgres container

To Do
-----
* MusicBrainz Lucene search mirror container

Instructions
------------
1. Provision Postgres server according to the [MusicBrainz project's instructions](https://github.com/metabrainz/musicbrainz-server/blob/master/INSTALL.md) or by building the included `musicbrainz-postgres` container (instructions [here](musicbrainz-postgres/README.md).
2. Build and run `musicbrainz-server` container (instructions [here](musicbrainz-server/README.md)).
