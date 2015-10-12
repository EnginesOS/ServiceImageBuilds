#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

if test -z $fqdn
 then
 	echo "fqdn not set"
 	exit 127
 fi


mkdir -p /home/wwwstats/confs/

cat /home/http_conf.tmpl | sed -e "/FQDN/s//$fqdn/" > /home/wwwstats/confs/https/$fqdn
cat /home/https_conf.tmpl | sed -e "/FQDN/s//$fqdn/" > /home/wwwstats/confs/http/$fqdn
 
mkdir -p /home/wwwstats/output/$fqdn/http/
mkdir -p /home/wwwstats/output/$fqdn/https/


