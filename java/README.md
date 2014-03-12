# nginx

A Dockerfile which produces a docker image that runs [Nginx][nginx].

[nginx]: http://wiki.nginx.org/


## Image Creation

```
$ sudo docker build -rm -t bySabi/nginx .
```

## Container Running

```
$ ./docker-run.sh
```

IMPORTANT!!
---------------------------
1- `docker-run.sh` is a hardcoded script. Edit with your settings before run. 


Files on '/data/nginx.localhost'

```
     sites-enabled
        nginx-site.conf
     www
        index.html
```

