# MariaDB

A Dockerfile which produces a docker image that runs [MariaDB][mariadb].

[mariadb]: https://mariadb.org/

## Image Creation

```
$ sudo docker build -rm -t bySabi/mariadb .
```

## Container Running

```
$ ./docker-run.sh
```

IMPORTANT!!
---------------------------
1- `docker-run.sh` is a hardcoded script. Edit with your settings before run.

2- default MariaDB `user/pass`: admin/admin.
