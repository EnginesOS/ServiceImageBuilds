#!/bin/sh


if ! test -d /home/ivpn/entries/sites/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 1
fi

sudo -n /home/engines/scripts/actionators/_restart_site2site_vpn.sh ${vpn_name}