#!/bin/sh



required_values="vpn_name"
check_required_values

if ! test -d  /home/ivpn/entries/disabled_users/
 then
  mkdir -p /home/ivpn/entries/disabled_users/
fi  


if ! test -d /home/ivpn/entries/disabled_users/${vpn_name}
 then
   echo '{"result":"'${vpn_name}' is not disabled"'
   exit 1
fi
mv /home/ivpn/entries/disabled_users/${vpn_name} /home/ivpn/entries/users/
sudo -n /home/engines/scripts/actionators/_disable_vpn_user.sh
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 1
fi