# all_domains.dev example


With this setup you can add any `.dev` site to `all_domains.dev/www` folder and launch. No need add domain to `hosts` file. Even not need restart Nginx server.


1- First add this to the end of `/etc/dnsmasq.conf`

```
# add all domain´s .lan to `hosts_.lan` file
local=/lan/
addn-hosts=/etc/hosts_.lan

# all domain´s not found  in `hosts_.dev` go to 192.168.0.32
# dynamic *.dev
address=/dev/192.168.0.32

# static .dev
local=/dev/
addn-hosts=/etc/hosts_.dev
```


File:  `/etc/hosts_.dev`

```
192.168.0.32 www.presta.dev
192.168.0.32 mariadb.dev
```

2- Put your site at, Ex: 
```
	/data/all_domains.dev/www/test.dev
```

3- Can make a symlink too, Ex: ( *** always create symlink on the same folder )
```
	$ ln -s test.dev www.test.dev
```

4- Launch:  (if nginx not found folder/domain return:  `No input file specified. ` )
```
	http://www.test.dev:49167
```


