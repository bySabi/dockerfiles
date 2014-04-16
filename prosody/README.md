# nginx-php5

A Dockerfile which produces a docker image that runs [Nginx][nginx] with [PHP5][php].

[nginx]: http://wiki.nginx.org/
[php]: http://us.php.net/

## Image Creation

```
$ sudo docker build -rm -t bySabi/nginx-php5 .
```

## Container Running

```
$ ./docker-run.sh
```

IMPORTANT!!
---------------------------
1- `docker-run.sh` is a hardcoded script. Edit with your settings before run. 


Files on '/data/nginx-php5.localhost'

```
     sites-enabled
        nginx-site.conf
     www
        index.html
```

