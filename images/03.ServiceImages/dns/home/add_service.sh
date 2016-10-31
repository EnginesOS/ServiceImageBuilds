#!/bin/bash

. /home/dns_functions.sh

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi


 . /tmp/.env

if test $ip = null
	then
	 	echo unset ip
		unset ip
	fi

if ! test -z $domain_name
         then
          if ! test $domain_name = engines.internal
           then
                  if test -z $ip
                   then
                                if  test  $ip_type = lan
                                 then
                                        ip=`cat /opt/engines/etc/net/ip`
                                elif   test  $ip_type = gw
                                then
                                   ip=`cat /opt/engines/etc/net/public`
                                fi
                 fi

                 if ! test -z $ip_type
                           then
                        touch /home/bind/domain_list/${ip_type}/${domain_name}
                        cat  /etc/bind/templates/config_file_zone_entry.tmpl | sed " /DOMAIN/s//${domain_name}/g" > /home/bind/engines/d
omains/${domain_name}
                        cat /etc/bind/templates/selfhosted.tmpl | sed "/DOMAIN/s//${domain_name}/g"\
                        		 | sed "/IP/s//${ip}/g" > /home/bind/engines/zones/named.conf.${domain_name}
                        cat /home/bind/engines/domains/* > /home/bind/engines/domains.hosted
                        kill -HUP `cat /var/run/named/named.pid`
                fi

                hostname=`echo $domain_name | sed "/[_.]/s//-/g"`
                domain_name=engines.internal
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
		exit 0
	else
		file=`cat /tmp/.dns_cmd`
		echo Error:With nsupdate $file
		exit 128
	fi
