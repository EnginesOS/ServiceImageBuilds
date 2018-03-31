#!/bin/bash

. /home/engines/functions/params_to_env.sh

parms_to_env

if ! test -d /home/ivpn/entries/site/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 2
fi


sudo -n /home/engines/scripts/configurators/_rm_site_vpn.sh "$vpn_name" 
if test $? -eq 0
 then
	echo "Success"
	exit 0
else
  exit 2
fi	
