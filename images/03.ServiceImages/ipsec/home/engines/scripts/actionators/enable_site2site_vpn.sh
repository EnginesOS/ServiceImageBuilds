#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env


required_values="vpn_name"
check_required_values

/home/ivpn/entries/sites/${vpn_name}

if ! test -d /home/ivpn/entries/disabled_sites/${vpn_name}
 then
   echo '{"result":"VPN does not exist as disabled '${vpn_name}'"}'
   exit 1
fi



mv  /home/ivpn/entries/disabled_sites/${vpn_name} /home/ivpn/entries/sites/
sudo -n /home/engines/scripts/actionators/_enable_site2site_vpn.sh ${vpn_name}

if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 1
fi