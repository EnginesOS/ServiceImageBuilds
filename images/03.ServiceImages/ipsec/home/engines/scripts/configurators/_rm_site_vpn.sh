#!/bin/bash

function rm_site_vpn {
if ! test -f /home/ivpn/entries/site/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 127
fi
rm /home/ivpn/entries/site/${vpn_name}

}

. /home/engines/functions/params_to_env.sh
params_to_env


required_values="vpn_name"
check_required_values


rm_site_vpn

ipsec stroke rereadsecrets
	
echo "Success"
exit 0
