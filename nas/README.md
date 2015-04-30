# NAS a Netatalk (afp server) + Samba4 + NFS + rsync + Google Drive

A Dockerfile which produces a docker image that runs [Netatalk][netatalk] , [Samba4][samba], [Google Drive client][drive], [NFS server] and [Rsync server].
A `afpd` share configured as a Time Capsule.
The image work like a NAS server with a dedicated IP in privileged mode using [pipework][pipe].

[netatalk]: http://netatalk.sourceforge.net/
[drive]: https://github.com/odeke-em/drive
[samba]: http://www.samba.org/



Use `doquer`[doquer], a homemade script for easy live docker.
[doquer]: https://github.com/bySabi/my_docker_util/tree/master/doquer

## Image Creation

```
$ doquer build
```

## Container Running

```
$ doquer run --pipe
```

## Add users

```
$ sudo doquer attach NAS
$ nas-user add usuario 1234
```

IMPORTANT!!
---------------------------
1- `docker-run.conf` is a hardcoded script. Edit your settings before run.

2- By default docker daemon `Max open files` limits  is too low and must set above `65535` otherwise `netatalk` malfunction (you see volume´s but can´t authenticate) .

See yourself:
```
$ tail -f /var/log/netatalk.log
.
..cnid_metad[38] {cnid_metad.c:415} (E:AFPDaemon): setlimits: Operation not permitted
.
```
To solve add: `limit nofile 65536 65536` to upstart script `/etc/init/docker.conf`. See [discussion][discu].
[discu]: https://groups.google.com/forum/#!msg/docker-user/T45Kc9vD804/xz7UZk_cilsJ

3- For avahi afp discovery need [pipework][pipe] for bind container to different IP than host. However can start container, `doquer run`, with default NATed subnet and add server address manually on `Finder`
[pipe]:https://github.com/jpetazzo/pipework



Users
-----

User management is performed through tdb(samba) and standard
Unix password/shadow files. Edit these files within the
etc/ directory and relaunch your containers.

For convenience, a user management tool is available as:

    $ nas-user [add|delete|password] <user> <password>

The password option is mandatory for 'add' and 'password'. If
supplied, the password is ignored for the 'delete' feature.

