# PostgreSQL

A Dockerfile which produces a docker image that runs [PostgreSQL][postgresql].

[postgresql]: http://www.postgresql.org/

## Image Creation

```
$ sudo docker build -rm -t bySabi/postgresql .
```

## Container Running

```
$ ./docker-run.sh
```

IMPORTANT!!
---------------------------
1- `docker-run.sh` is a hardcoded script. Edit with your settings before run.

2- default PostgreSQL `user/pass`: postgres/postgres.
