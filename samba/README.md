# Samba

A Dockerfile which produces a docker image that runs [Samba][samba]. Based on work of [ewindisch/docker-samba][ewindisch]


[samba]: http://www.samba.org/
[ewindisch]: https://github.com/ewindisch/docker-samba

## Image Creation

```
$ sudo docker build -rm -t bySabi/samba .
```

## Container Running

```
$ ./docker-run.sh
```

## Add users

```
$ ./docker-run.sh console
$ samba-user add usuario 1234
#test ?
$ service samba start
```

Note
-------
`docker-run.sh` is a hardcoded script. Edit with your settings before run.

Users
-----

User management is performed through tdb and standard
Unix password/shadow files. Edit these files within the
etc/ directory and relaunch your containers.

For convenience, a user management tool is available as:

    $ ./samba-user [add|delete|password] <user> <password>

The password option is mandatory for 'add' and 'password'. If
supplied, the password is ignored for the 'delete' feature.

