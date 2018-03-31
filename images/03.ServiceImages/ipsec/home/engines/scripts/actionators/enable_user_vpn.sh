#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env


required_values="vpn_name"
check_required_values

if ! test -d  /home/ivpn/entries/disabled_users/
 then
  mkdir -p /home/ivpn/entries/disabled_users/
fi  


if ! test -f /home/ivpn/entries/disabled_users/${vpn_name}
 then
   echo '{"result":"'${vpn_name}' is not disabled"'
   exit 2
fi
mv /home/ivpn/entries/disabled_users/${vpn_name} /home/ivpn/entries/user/
sudo -n /home/engines/scripts/actionators/_disable_user_vpn.sh
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 2
fi