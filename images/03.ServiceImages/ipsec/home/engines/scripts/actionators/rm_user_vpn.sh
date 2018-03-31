#!/bin/bash

if ! test -f /home/ivpn/entries/user/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 2
fi

rm /home/ivpn/entries/user/${vpn_name}
 

sudo -n /home/engines/scripts/configurators/_rm_user_vpn.sh