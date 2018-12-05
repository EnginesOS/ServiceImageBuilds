#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/domain_name
 then
  
PARAMS_DIR=/home/engines/scripts/configurators/saved/
domain_name=`cat $PARAMS_DIR/domain_name`
subnet=`cat $PARAMS_DIR/subnet`
start=`cat $PARAMS_DIR/start`
end=`cat $PARAMS_DIR/end`
default_lease=`cat $PARAMS_DIR/default_lease`
default_gateway=`cat $PARAMS_DIR/default_gateway`
dns_server1=`cat $PARAMS_DIR/dns_server1`
dns_server2=`cat $PARAMS_DIR/dns_server2`
netmask=`cat $PARAMS_DIR/netmask`

 echo '{"subnet":"'$subnet'",
 		"start":"'$start'",
 		"start":"'$start'",
  		"end":"'$end'",	
		"netmask":"'$netmask'", 		 	
 		"default_lease":"'$default_lease'",
 		"default_gateway":"'$default_gateway'", 		
	    "domain_name":"'$domain_name'", 	
		"dns_server1":"'$dns_server1'", 	
		"dns_server2":"'$dns_server2'"}' 			  				
else
  echo '{"dhcpd_settings":"Not Set"}'
fi
exit 0