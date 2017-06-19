#!/bin/bash

function rm_user_vpn {
if ! test -f /home/ivpn/entries/user/${vpn_name}
 then
   echo "No Such VPN ${vpn_name}"
   exit 128
fi
 
rm /home/ivpn/entries/user/${vpn_name}
cp /home/ipsec.secrets.head /etc/ipsec.secrets
cat /home/ivpn/entries/user/* >> /etc/ipsec.secrets
ipsec stroke rereadsecrets
}


. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z "${vpn_name}" 
then
 echo Error:Missing VPN Name
 exit -1
fi

rm_user_vpn
	
echo "Success"
exit 0
