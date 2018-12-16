#!/bin/sh


 . /home/engines/functions/checks.sh

required_values="vpn_name"
check_required_values


if ! test -d /home/ivpn/entries/users/${vpn_name}
 then
   echo '{"result":"VPN User does not exist '${vpn_name}'"}'
   exit 1
fi

if ! test -d  /home/ivpn/entries/disabled_users/
 then
  mkdir -p /home/ivpn/entries/disabled_users/
fi  

mv /home/ivpn/entries/users/${vpn_name} /home/ivpn/entries/disabled_users/
sudo -n /home/engines/scripts/actionators/_disable_vpn_user.sh
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 1
fi