# musicbrainz-server Container

Based on the official Ubuntu 15.10 container, this container runs MusicBrainz
Server (from the official [git repo](https://github.com/metabrainz/musicbrainz-server)
).

**Current Version:** `v-2016-03-07`

Prerequisites
-------------

1. Ensure you have an accessible Postgres server provisioned as per [here](../README.md).

2. *Optional:* As the MusicBrainz install pulls down a pile of packages and Perl
modules, I highly suggest setting up an HTTP caching proxy (like Squid) and
modify the Dockerfile appropriately (see commented-out lines) to use it.  This
will save you lots of time on re-runs.  (*Note:* I couldn't get `npm install` to
work correctly through my Squid proxy.  Any advice would be appreciated.)

Build Instructions
------------------

1. Modify `DBDefs.pm` to match your environment.  By default it's configured
appropriately for the related `musicbrainz-postgres` container linked according
to the **Usage Instructions** below. (Make sure to set your personal
`REPLICATION_ACCESS_TOKEN` as instructed in the file.)

2. Build `musicbrainz-server` container (this will take a while)

```
docker build -t musicbrainz-server .
```

Usage Instructions
------------------

The base recommended Docker command to run this container is...

```
docker run -i -t --rm --name musicbrainz-server musicbrainz-server ...
```

If you're using the related `musicbrainz-postgres` (or another Postgres)
container, you can link your `musicbrainz-server` containers to it to simplify
networking.  Assuming the Postgres container is called `musicbrainz-postgres`,
your base Docker parameters would look something like this:

```
docker run -i -t --rm --name musicbrainz-server --link musicbrainz-postgres:db musicbrainz-server ...
```

This will let you refer to the Postgres host as `db` in `DBDefs.pm` and
elsewhere in your `musicbrainz-server` container.

The rest of the instructions will refer to whatever your base command is as
`<BASE COMMAND>`.


### Intantiate MusicBrainz database

Download and load latest database dump (recommended):

```
<BASE COMMAND> /opt/musicbrainz/loaddb.sh
```

The `loaddb.sh` script will locate and pull down the latest MusicBrainz database
dump from `ftp://ftp.musicbrainz.org/pub/musicbrainz/data/fullexport/` to `/tmp`
inside the container.  As these files total upwards of 5GB and extract to much
larger than that, I highly recommend mounting a host path to `/tmp` to improve
performance and keep the container size small (i.e. `... -v /some/host/path:/tmp`).

If you just want to initialize a clean database (not recommended):

```
<BASE COMMAND> /opt/musicbrainz/loaddb.sh --clean
```

### Update MusicBrainz database

Update the MusicBrainz database with replication packets:

```
<BASE COMMAND> /opt/musicbrainz/updatedb.sh
```

You run this at any time, even with a live `musicbrainz-server` container running
separately (although I wouldn't run more than one update at once...I don't know
how the DB will handle that.)

### Start MusicBrainz Server

```
<BASE COMMAND> /opt/musicbrainz/start.sh
```

Don't forget to add `-p 5000:5000` (or whatever you've configured the web port
to be) to your `<BASE COMMAND>` before the container name!
