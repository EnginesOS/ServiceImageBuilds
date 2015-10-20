#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/default_site_url

. /home/engines/scripts/functions.sh

load_service_hash_to_environment


echo $1 |grep = >/dev/null
        if test $? -ne 0
        then
                exit
        fi

res="${1//[^:]}"
echo $res
fcnt=${#res}
fcnt=`expr $fcnt + 1`

        while test $fcnt -ge $n
        do
                nvp="`echo $1 |cut -f$n -d:`"
                n=`expr $n + 1`
                name=`echo $nvp |cut -f1 -d=`
                if ! test -z $name 
                	then
                	value="`echo $nvp |cut -f2 -d=`"
                		if ! test -z $value
                			then
                			export $name="$value"
                		fi
                fi
        done
        
        
   	if test  ${#default_site_url} -gt 4
	then  
	
	cat /etc/nginx/templates/default_site.tmpl | sed "/FQDN/s//$default_site_url/" > /tmp/site.fqdn
	 cp /tmp/site.fqdn /etc/nginx/sites-enabled/default

 else
 	cp 	cat /etc/nginx/templates/empty_default /etc/nginx/sites-enabled/default 	
 	fi
 
exit 0
