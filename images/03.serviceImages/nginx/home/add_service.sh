#!/bin/bash

service_hash=$1

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

if test -z $fqdn
 then
 	echo Error:no FQDN in nginx service hash
 	exit -1
 fi
 
 if test -z $port
 then
 	echo Error:no port in nginx service hash
 	exit -1
 fi
  if test -z "$proto"
 then
 	echo Error:no proto in nginx service hash
 	exit -1
 fi
 
   if test -z $parent_engine
 then
 	echo Error:no name in nginx service hash
 	exit -1
 fi
 
 res=`nslookup ${parent_engine}.engines.internal`
 if test $? -lt 0
  then
  	echo Error:failed to find internal dns entry for ${parent_engine}.engines.internal
  	exit -1
 fi  

	  res=`nslookup ${parent_engine}.engines.internal`

 teststr=`echo $res |grep NXDOMAIN`
 if test ${#teststr} -gt 0
  then
        echo Error:failed to find internal dns entry for ${parent_engine}.engines.internal
        exit -1
 fi
	 

template="/etc/nginx/templates/${proto}_site.tmpl"

cat $template | sed "/FQDN/s//$fqdn/" > /tmp/site.fqdn
cat /tmp/site.fqdn  | sed "/PORT/s//$port/" > /tmp/site.port
cat /tmp/site.port  | sed "/SERVER/s//$parent_engine/" > /tmp/site.name

if test "$proto" = default 
 then
    cp /tmp/site.name /etc/nginx/sites-enabled/default
 elif ! test "$proto" = http
	 then
	 	if test -f /etc/nginx/ssl/certs/$fqdn.crt
	 		then
	 			cert_name=$fqdn
	        else
	        	 cert_name=engines
	     fi
	    cat /tmp/site.name  | sed "/CERTNAME/s//$cert_name/" > /etc/nginx/sites-enabled/${proto}_${fqdn}.site
	 else
	 	cp /tmp/site.name /etc/nginx/sites-enabled/${proto}_${fqdn}.site
fi
	 
	 rm /tmp/site.*
	 
	 kill -HUP `cat /run/nginx/nginx.pid`
	 
	 echo Success
