#!/bin/sh

 . /home/engines/functions/checks.sh

required_values="vpn_name"
check_required_values
vpn_name=`echo $vpn_name |sed "s/[ .;&]//g"`
if  test -z ${vpn_name}
 then
	 echo '{"result":"No Such VPN '${vpn_name}'"'
   exit 1
fi	

	

if  test -d /home/ivpn/entries/users/${vpn_name}
 then
  rm -r /home/ivpn/entries/users/${vpn_name}
 elif test -d /home/ivpn/entries/disabled_users/${vpn_name}
 then
  rm -r /home/ivpn/entries/disabled_users/${vpn_name}
 else 
   echo '{"result":"No Such VPN '${vpn_name}'"'
   exit 1
fi


sudo -n /home/engines/scripts/actionators/sudo/_rm_vpn_user.sh
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 1
fi