#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/configurators/saved/dyndns_settings
parms_to_file_and_env

if test -z $provider
 then
 	echo "provider not set"
 	exit 127
 fi
 
if test -z $login
 then
 	echo "login not set"
 	exit 127
 fi
 
 if test -z $login
 then
 	echo "login not set"
 	exit 127
 fi
 
 if test -z $domain_name
 then
 	echo "domain_name not set"
 	exit 127
 fi

cat /home/providers/$provider/dyndns.conf.tmpl |sed --e /LOGIN/s//$login/ -e /PASSWORD/s//$password/ -e /DOMAIN/s//$domain_name/ >/home/dyndns/dyndns.conf 
chmod og-r /home/dyndns/dyndns.conf
echo "Success"
exit 0
