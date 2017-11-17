#!/bin/bash

. /home/engines/scripts/services/dns_functions.sh

. /home/engines/functions/params_to_env.sh
params_to_env

if ! test -z $ip
 then
   if test $ip = null -o  $ip = nil
     then
      echo unset ip
      unset ip
   fi
fi

if ! test -z $domain_name
 then
   if ! test $domain_name = engines.internal
    then
      if test -z $ip
        then
           if test  $ip_type = lan
             then
               ip=`cat /home/engines/system/net/ip`
           elif  test  $ip_type = gw
              then
                ip=`cat /home/engines/system/net/public`
           fi
      fi
     if ! test -z $ip_type
       then
          touch /home/bind/domain_list/${ip_type}/${domain_name}
          cat  /home/engines/templates/dns/config_file_zone_entry.tmpl | sed " /DOMAIN/s//${domain_name}/g" > /home/bind/engines/domains/${domain_name}
          cat /home/engines/templates/dns/selfhosted.tmpl | sed "/DOMAIN/s//${domain_name}/g"\
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
