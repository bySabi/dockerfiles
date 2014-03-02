# docker bash_completion patch

Enable directory completion for '-v' on 'run' command.

Create with:
```
$ diff -u docker docker.v2 > docker_patch.diff
```

## How applied

Download ´docker´ bash completion file and install (ubuntu)

```
$ curl -O https://raw.github.com/dotcloud/docker/master/contrib/completion/bash/docker
$ sudo install -o root -m 644 docker /etc/bash_completion.d/

```

## Apply patch

```
$ curl -O https://raw.github.com/bySabi/dockerfiles/master/doquer/docker-bash_completion-patch/docker_patch.diff
$ sudo patch -p0 < docker_patch.diff
```

