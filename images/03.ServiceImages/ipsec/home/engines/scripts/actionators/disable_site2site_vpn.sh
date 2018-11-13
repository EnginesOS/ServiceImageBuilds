#!/bin/sh



required_values="vpn_name"
check_required_values

/home/ivpn/entries/sites/${vpn_name}

if ! test -d /home/ivpn/entries/sites/${vpn_name}
 then
   echo '{"result":"VPN does not exist '${vpn_name}'"}'
   exit 1
fi

if ! test -d  /home/ivpn/entries/disabled_sites/
 then
  mkdir -p /home/ivpn/entries/disabled_sites/
fi  

mv  /home/ivpn/entries/sites/${vpn_name} /home/ivpn/entries/disabled_sites/
sudo -n /home/engines/scripts/actionators/_disable_site2site_vpn.sh ${vpn_name}

if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 1
fi