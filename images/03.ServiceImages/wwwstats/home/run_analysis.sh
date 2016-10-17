#!/bin/sh

for proto in http https
	do
	for site in `ls /home/wwwstats/confs/$proto/`
	  do
		if test -f /var/log/www/$site/$proto/access.log
			then
				webalizer -c /home/wwwstats/confs/$proto/$site
			fi
	  done
	done	


