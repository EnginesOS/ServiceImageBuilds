#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

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
 


res=`nslookup ${parent_engine}.engines.internal|grep -e "Address: *[0-9]" |awk '{print $2}'`

 `echo $res | grep -e "[0-9].*\.[0-9].*\.[0-9].*" >/dev/null`
 if test $? -ne 0
  then
        echo Error:failed to find internal dns entry for ${parent_engine}.engines.internal
        exit -1
 fi
	 
	 echo $1 > /home/consumers/saved/${proto}_$fqdn

template="/etc/nginx/templates/${proto}_site.tmpl"


resolv_ip=`nslookup control |grep -e "Address: *[0-9]" |awk '{print $2}'`

servers="server SERVER.engines.internal:PORT;"
cnt=1
if ! test -z $engine_count
 then
 	if test $engine_count -gt 1
 	 then
 	 	while test $cnt -le  $engine_count
 	 		do
 	 		    if test $cnt -ne 1
 	 			  then
 	 				n=$cnt 	 	   
 	 				servers="$servers server SERVER$n.engines.internal:PORT;"
 	 			fi
 	 		  cnt=`expr $cnt + 1 `			
 	 		done 
 	fi
 fi
 
cat $template | sed "/SERVERS/s//$servers/" > /tmp/servers.tmpl

cat /tmp/servers.tmpl | sed "/FQDN/s//$fqdn/g" > /tmp/site.fqdn
cat /tmp/site.fqdn  | sed "/PORT/s//$port/g" > /tmp/site.port
cat /tmp/site.port  | sed "/SERVER/s//$parent_engine/g" > /tmp/site.engine_name
cat /tmp/site.engine_name | sed "/RESOLV_IP/s//$resolv_ip/" > /tmp/site.res

www_path=`echo $internal_dir  |sed "s/^\///" |sed "s/\/$//"`


rewrite=""
   if ! test -z $www_path
 then
    rewrite='rewrite \^\/'$www_path'\/\(\.\*\) \/'$www_path'\/\$1  break;\
        rewrite \^\/\(\.\*\) $fqdn\/'$www_path'\/\$1  break; '
fi
cat /tmp/site.res | sed "/FOLDER/s//$rewrite/" >  /tmp/site.path
store_pre=${container_type}_${parent_engine}
domain=`echo $fqdn  | cut -f2- -d.`
if test "$proto" = default 
 then
    cp /tmp/site.name /etc/nginx/sites-enabled/default
 elif ! test "$proto" = http
	 then
	 	if test -f /etc/nginx/ssl/certs/${store_pre}_${fqdn}.crt
	 		then
	 			cert_name=${store_pre}_${fqdn}
	 		elif 	 test -f /etc/nginx/ssl/certs/${domain}.crt
	 		 then
	 		 	cert_name=$domain
	        else
	        	 cert_name=system_system_engines
	     fi
		if test -f /etc/nginx/sites-enabled/http_https_${fqdn}.site
	     		then
	     			rm -f /etc/nginx/sites-enabled/http_https_${fqdn}.site
	     	fi
		if test -f /etc/nginx/sites-enabled/https_${fqdn}.site
	     		then
	     			rm -f /etc/nginx/sites-enabled/https_${fqdn}.site
	     	fi
	     	if test -f /etc/nginx/sites-enabled/http_${fqdn}.site
	     		then
	     			rm -f /etc/nginx/sites-enabled/http_${fqdn}.site
	     	fi
	    cat /tmp/site.path  | sed "/CERTNAME/s//$cert_name/" > /etc/nginx/sites-enabled/${proto}_${fqdn}.site
	 else  #Proto is http
		if test -f /etc/nginx/sites-enabled/http_${fqdn}.site
	     		then
	     			rm -f /etc/nginx/sites-enabled/http_${fqdn}.site
	     	fi
		if test -f /etc/nginx/sites-enabled/http_https_${fqdn}.site
	     		then
	     			rm -f /etc/nginx/sites-enabled/http_https_${fqdn}.site
	     	fi
		if test -f /etc/nginx/sites-enabled/https_${fqdn}.site
	     		then
	     			rm -f /etc/nginx/sites-enabled/https_${fqdn}.site
	     	fi
	 	cp /tmp/site.path /etc/nginx/sites-enabled/${proto}_${fqdn}.site
fi

mkdir -p /tmp/last_run
cp 	/tmp/site.* /tmp/last_run

rm /tmp/site.*

	 if ! test -d /var/log/nginx/$fqdn/https/
	 	then
	 		mkdir -p /var/log/nginx/$fqdn/https/
	 	fi
 	if ! test -d /var/log/nginx/$fqdn/http/
 	then
 		mkdir -p /var/log/nginx/$fqdn/http/
 	fi
 	
 kill -HUP `cat /run/nginx/nginx.pid`
	 
	 echo Success
