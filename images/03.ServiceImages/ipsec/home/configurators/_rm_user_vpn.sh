#!/bin/bash

function rm_user_vpn {
if ! test -f /home/ivpn/entries/user/${vpn_name}
 then
 echo "No Such VPN ${vpn_name}"
 fi
 
rm /home/ivpn/entries/user/${vpn_name}
cp /home/ipsec.secrets.head /etc/ipsec.secrets
cat /home/ivpn/entries/user/* >> /etc/ipsec.secrets
ipsec stroke rereadsecrets
}


if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env>/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env
#FIXME make engines.internal settable



	if test -z "${vpn_name}" 
	then
	  echo Error:Missing VPN Name
       exit -1
  fi

	rm_user_vpn
	
echo "Success"
exit 0
