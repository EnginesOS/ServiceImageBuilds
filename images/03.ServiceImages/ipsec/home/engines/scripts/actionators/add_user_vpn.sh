#!/bin/bash

function add_user_vpn {

password=`echo -n "${password}" | iconv -t utf16le | openssl md4`

 #echo "${vpn_name} : EAP \"${password}\"" > /home/ivpn/entries/user/${vpn_name}
 echo "${vpn_name} : NTLM \"${password}\"" > /home/ivpn/entries/user/${vpn_name}
 echo "" >> /home/ivpn/entries/user/${vpn_name}

}

. /home/engines/functions/params_to_env.sh
params_to_env


required_values="vpn_name password"
check_required_values

if ! test -f /home/ivpn/entries/user/${vpn_name}
 then
   echo '{"result":"VPN User Exists '${vpn_name}'"}'
   exit 2
fi
    
add_user_vpn

err=`sudo -n /home/engines/scripts/configurators/_add_user_vpn.sh`
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 2
fi
	
