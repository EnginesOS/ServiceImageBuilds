#!/bin/bash

. /home/engines/functions/params_to_env.sh

parms_to_env

if ! test -d /home/ivpn/entries/site/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 2
fi

cat /home/ivpn/entries/site/${vpn_name}/params
