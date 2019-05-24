#!/bin/sh
 . /home/engines/functions/checks.sh

required_values="vpn_name"
check_required_values

if ! test -d /home/ivpn/entries/sites/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 1
fi

sudo -n /home/engines/scripts/actionators/sudo/_stop_site2site_vpn.sh ${vpn_name}