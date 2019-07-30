#!/bin/sh
show_zone_file()
{
cat /home/bind/engines/zones/named.conf.$domain_name |egrep "CNAME|TXT|A|IN|NS|MX"
}
if ! test -z $domain_name
 then
  if test -f /home/bind/engines/zones/named.conf.$domain_nam
   then
     show_zone_file
   else
    echo Domain $domain_name is not self hosted
  fi    
else
   cd /home/bind/engines/zones
    for domain_name in ` ls | sed "/named.conf./s///"`
     do
       echo $domain_name
       show_zone_file      
     done
fi     