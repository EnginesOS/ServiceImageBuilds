#!/bin/bash
 . /home/engines/functions/checks.sh
add_user_vpn()
 {

password=`echo -n "${password}" | iconv -t utf16le | openssl md4|cut -f2 -d" "`

 #echo "${vpn_name} : EAP \"${password}\"" > /home/ivpn/entries/users/${vpn_name}/secret
 echo "${vpn_name} : NTLM \"${password}\"" > /home/ivpn/entries/users/${vpn_name}/secret
 echo "" >> /home/ivpn/entries/users/${vpn_name}/secret

}

required_values="vpn_name password"
check_required_values

if ! test -d /home/ivpn/entries/users/${vpn_name}
 then
   echo '{"result":"VPN User does not exist '${vpn_name}'"}'
   exit 1
fi

add_user_vpn

err=`sudo -n /home/engines/scripts/actionators/_set_vpn_user_pass.sh`
if test $? -eq 0
 then
	echo '{"result":"Success"}'
	exit 0
else
 	echo '{"result":"'$err'"}'
	exit 1
fi
	
