#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env


required_values="vpn_name"
check_required_values


if ! test -f /home/ivpn/entries/user/${vpn_name}
 then
   echo '{"result":"VPN User does not exist '${vpn_name}'"}'
   exit 2
fi

if ! test -d  /home/ivpn/entries/disabled_users/
 then
  mkdir -p /home/ivpn/entries/disabled_users/
fi  

mv /home/ivpn/entries/user/${vpn_name} /home/ivpn/entries/disabled_users/
sudo -n /home/engines/scripts/configurators/_disable_user_vpn.sh
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 2
fi