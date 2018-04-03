#!/bin/bash
. /home/engines/functions/params_to_env.sh

params_to_env

if ! test -d /home/ivpn/entries/sites/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 1
fi

sudo -n /home/engines/scripts/actionators/_start_site2site_vpn.sh ${vpn_name}