#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment


if test -z $fqdn
 then
 	echo "fqdn not set"
 	exit 127
 fi
 
rm /home/wwwstats/confs/*/$fqdn