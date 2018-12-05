#!/bin/sh

 . /home/engines/functions/checks.sh

required_values="vpn_name"
check_required_values

if ! test -d /home/ivpn/entries/sites/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 1
fi

cat /home/ivpn/entries/sites/${vpn_name}/params
