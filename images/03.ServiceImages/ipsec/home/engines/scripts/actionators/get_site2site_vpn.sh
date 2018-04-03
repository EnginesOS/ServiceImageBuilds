#!/bin/bash

. /home/engines/functions/params_to_env.sh

parms_to_env

if ! test -d /home/ivpn/entries/sites/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 1
fi

cat /home/ivpn/entries/sites/${vpn_name}/params
