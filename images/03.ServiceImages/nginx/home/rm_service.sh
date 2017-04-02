#!/bin/bash

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env


if test -z $fqdn
 then
 	echo "Error:no FQDN in nginx service hash"
 	exit -1
 fi


if test -f /home/consumers/saved/${proto}_$fqdn
 then
 	rm -f /home/consumers/saved/${proto}_$fqdn
 fi
 
	if test -f /etc/nginx/sites-enabled/${proto}_${fqdn}.site
	 then
	 	rm /etc/nginx/sites-enabled/${proto}_${fqdn}.site	 
	 	kill -HUP `cat /var/run/nginx/nginx.pid`
	else
		echo Success with Warning:config /etc/nginx/sites-enabled/${proto}_${fqdn}.site not found
		exit 0
	fi
	 
	 echo Success
	 