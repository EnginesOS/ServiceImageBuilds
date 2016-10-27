#!/bin/bash

. /home/dns_functions.sh

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env

	if ! test -z ${domain_name}
	 then
	  if ! test ${domain_name} = engines.internal
	   then
	   	if test -z ${ip}
			then
				echo Error:Missing IP Address
        		exit 128
   		 fi
	   touch /home/bind/domain_list/${ip_type}/${domain_name}
	 	cat  /etc/bind/templates/config_file_zone_entry.tmpl | sed " /DOMAIN/s//${domain_name}/g" > /home/bind/engines/domains/${domain_name}
	 	cat /etc/bind/templates/selfhosted.tmpl | sed "/DOMAIN/s//${domain_name}/g" | sed "/IP/s//${ip}/g" > /home/bind/engines/zones/named.conf.${domain_name}
	 	cat /home/bind/engines/domains/* > /home/bind/engines/domains.hosted
	 	kill -HUP `cat /var/run/named/named.pid`
	 	domain_name=engines.internal
	 	hostname=public
	 	add_to_internal_domain
	 	echo Success
	 	exit 0
	   fi
	 fi

#FIXME make engines.internal settable

add_to_internal_domain
	
	if test $? -eq 0
	then
		echo Success
		#exit 0
	else
	file=`cat /tmp/.dns_cmd`
		echo Error:With nsupdate $file
		exit 128
	fi
	
	
	if ! test -z ${ip}
		then
			ip_reversed=`echo $ip |awk  ' BEGIN {  FS="."} {print $4 "." $3 "." $2 "." $1}'`
			echo server 127.0.0.1 > /tmp/.rdns_cmd
			echo update delete ${ip_reversed}.in-addr.arpa. >> /tmp/.rdns_cmd
			echo update add ${ip_reversed}.in-addr.arpa.  30 IN PTR $fqdn_str  >> /tmp/.rdns_cmd
			echo send >> /tmp/.rdns_cmd
			nsupdate -k /etc/bind/keys/ddns.private /tmp/.rdns_cmd
	
				if test $? -eq 0
					then
						echo Success
						exit 0
				else	
					file=`cat /tmp/.rdns_cmd`
					echo Error:With nsupdate $file
					exit 128
				fi
	 fi
