# Netatalk (afp server)

A Dockerfile which produces a docker image that runs [Netatalk][netatalk] . Based on work of [grigio/docker-timemachine][grigio].
A `afpd` share configured as a Time Capsule.

[netatalk]: http://netatalk.sourceforge.net/
[grigio]: https://github.com/grigio/docker-timemachine

## Image Creation

```
$ sudo docker build -rm -t bySabi/netatalk .
```

## Container Running

```
$ ./docker-run.sh
```

## Add users

```
$ ./docker-run.sh console
$ netatalk-user add usuario 1234
```

IMPORTANT!!
---------------------------
1- `docker-run.sh` is a hardcoded script. Edit with your settings before run. 

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

3- For avahi afp discovery use `docker-run.sh daemon3`, need [pipework][pipe] for bind container to different IP than host. However can start container, `docker-run.sh daemon`, with default NATed subnet and add server address manually on `Finder`
[pipe]:https://github.com/jpetazzo/pipework



Users
-----

User management is performed through tdb and standard
Unix password/shadow files. Edit these files within the
etc/ directory and relaunch your containers.

For convenience, a user management tool is available as:

    $ ./netatalk-user [add|delete|password] <user> <password>

The password option is mandatory for 'add' and 'password'. If
supplied, the password is ignored for the 'delete' feature.

