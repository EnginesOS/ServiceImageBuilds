#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/dhcpd_settings

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

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


