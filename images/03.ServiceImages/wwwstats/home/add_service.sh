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


mkdir -p /home/wwwstats/confs/http
mkdir -p /home/wwwstats/confs/https
cat /home/templates/http_config.tmpl | sed -e "/FQDN/s//$fqdn/" > /home/wwwstats/confs/http/$fqdn
cat /home/templates/https_config.tmpl | sed -e "/FQDN/s//$fqdn/" > /home/wwwstats/confs/https/$fqdn
 
mkdir -p /home/wwwstats/output/$fqdn/http/
mkdir -p /home/wwwstats/output/$fqdn/https/


