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
 	echo "fqdn not set"
 	exit 127
 fi
 
rm /home/wwwstats/confs/*/$fqdn