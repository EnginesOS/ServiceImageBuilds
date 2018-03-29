#!/bin/bash

. /home/engines/functions/params_to_env.sh

parms_to_env

if ! test -d /home/ivpn/entries/site/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 127
fi


vpn_name=`echo $vpn_name | sed "s/[&;]//"`
sudo -n /home/engines/scripts/configurators/_rm_site_vpn.sh $vpn_name 

rm -r /home/ivpn/entries/site/${vpn_name}