# owncloud

A Dockerfile which produces a docker image that runs [Owncloud][owncloud] over [Nginx][nginx].

[owncloud]: http://http://owncloud.org/
[nginx]: http://wiki.nginx.org/

## Image Creation

```
$ sudo docker build -rm -t bySabi/owncloud .
```

## Container Running

```
$ sudo docker run -d -v /data/cloud.iguanalab.lan:/data -p 443 bySabi/owncloud
```
