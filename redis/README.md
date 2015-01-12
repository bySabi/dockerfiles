# Redis

A Dockerfile which produces a docker image that runs [Redis][redis].

[redis]: https://redis.io/

## Image Creation

```
$ sudo docker build -rm -t bySabi/redis .
```

## Container Running

```
$ ./docker-run.sh
```

IMPORTANT!!
---------------------------
1- `docker-run.sh` is a hardcoded script. Edit with your settings before run.

2- default Redis `user/pass`: admin/admin.
