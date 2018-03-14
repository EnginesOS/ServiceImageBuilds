#!/bin/bash

. /home/engines/scripts/services/dns_functions.sh

. /home/engines/functions/params_to_env.sh
params_to_env
 
if test $type = "domain"
  then        
     if test $wan_or_lan = lan
        then
          ip=`cat /home/engines/system/net/ip`
      elif test  $wan_or_lan = wan
         then
           ip=`cat /home/engines/system/net/public`
      fi
   touch /home/bind/domain_list/${wan_or_lan}/${domain_name}   
   cat /home/engines/templates/dns/config_file_zone_entry.tmpl | sed " /DOMAIN/s//${domain_name}/g" > /home/bind/engines/domains/${domain_name}
   cat /home/engines/templates/dns/selfhosted.tmpl | sed "/DOMAIN/s//${domain_name}/g"\
         | sed "/IP/s//${ip}/g" > /home/bind/engines/zones/named.conf.${domain_name}
   cat /home/bind/engines/domains/* > /home/bind/engines/domains.hosted
   kill -HUP `cat /home/engines/run/named.pid`
   echo Success
   exit 0
fi


domain_name=engines.internal
add_to_internal_domain
echo Success
exit 0

