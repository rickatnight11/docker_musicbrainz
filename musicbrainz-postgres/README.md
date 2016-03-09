# musicbrainz-postgres Container

This container is based on the official `postgres` container.  By default it
will create a `musicbrainz` DB superuser (password same as username) for
MusicBrainz to use.  On first run, it will initialize a database called
`musicbrainz`, as well. (To change these settings, see **Prerequisites**
section below.)

Prerequisites
-------------

1. *Optional:* I suggest provisioning at least 60GB of host-based disk to mount
into your `musicbrainz-postgres` container for the Postgres DB files, instead
of storing them inside the container, for performance and usability.

2. *Optional:* As the MusicBrainz install pulls down a pile of packages and
Perl modules, I highly suggest setting up an HTTP caching proxy (like Squid)
and modify the Dockerfile appropriately (see commented-out lines) to use it.
This will save you lots of time on re-runs.

3. *Optional:* To change any of the default postgres settings (user, password,
database, path, etc), modify the `ENV` lines in the `Dockerfile` accordingly.
(See the [official Postgres docker page](https://hub.docker.com/r/_/postgres/)
for details.)

Build Instructions
------------------
1. Build `musicbrainz-postgres` container:

```
docker build -t musicbrainz-postgres .
```

Usage Instructions
------------------

The base recommended Docker command to run this container is...

```
docker run -t --rm 5432:5432 --name musicbrainz_postgres musicbrainz_postgres ...

```

If you have host-based storage available for the Postgres DB files
(recommended), adjust the base command accordingly:


```
docker run -t --rm  -v /path/to/storage/location:/var/lib/postgresql -p 5432:5432 --name musicbrainz_postgres musicbrainz_postgres ...
```
