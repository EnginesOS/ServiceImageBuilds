#!/bin/bash

function add_user_vpn {

password=`echo -n "${password}" | iconv -t utf16le | openssl md4`

 #echo "${vpn_name} : EAP \"${password}\"" > /home/ivpn/entries/users/${vpn_name}/secret
 echo "${vpn_name} : NTLM \"${password}\"" > /home/ivpn/entries/users/${vpn_name}/secret
 echo "" >> /home/ivpn/entries/user/${vpn_name}/secret

}

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=`mktemp`
parms_to_file_and_env
#params_to_env


required_values="vpn_name password"
check_required_values

if test -d /home/ivpn/entries/users/${vpn_name}/
 then
   echo '{"result":"VPN user exists '${vpn_name}'"}'
   exit 2 
 elif test -d /home/ivpn/entries/disabled_users/${vpn_name}/  
 then
   echo '{"result":"VPN user exists in disabled users '${vpn_name}'"}'
   exit 2 
fi
 
mkdir -p /home/ivpn/entries/users/${vpn_name}
cat $PARAMS_FILE | sed "s/\"password\".*:.*".*"//" > /home/ivpn/entries/users/${vpn_name}/details
rm    $PARAMS_FILE 
add_user_vpn

err=`sudo -n /home/engines/scripts/actionators/_add_vpn_user.sh`
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 2
fi
	
