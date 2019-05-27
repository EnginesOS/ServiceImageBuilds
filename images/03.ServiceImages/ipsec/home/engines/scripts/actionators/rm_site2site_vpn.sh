#!/bin/sh
 . /home/engines/functions/checks.sh


required_values="vpn_name"
check_required_values
if ! test -d /home/ivpn/entries/sites/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 1
fi


sudo -n /home/engines/scripts/actionators/sudo/_rm_site_vpn.sh "$vpn_name" 
if test $? -eq 0
 then
	echo "Success"
	exit 0
else
  exit 1
fi	
