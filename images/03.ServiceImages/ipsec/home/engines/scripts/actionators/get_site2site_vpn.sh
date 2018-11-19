#!/bin/sh



if ! test -d /home/ivpn/entries/sites/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 1
fi

cat /home/ivpn/entries/sites/${vpn_name}/params
