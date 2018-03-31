#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env


if ! test -f /home/ivpn/entries/user/${vpn_name}
 then
   echo '{"result":"No Such VPN '${vpn_name}'"'
   exit 2
fi

rm /home/ivpn/entries/user/${vpn_name}
 

sudo -n /home/engines/scripts/configurators/_rm_user_vpn.sh
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 2
fi