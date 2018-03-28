#!/bin/bash

function add_user_vpn {
#cp /tmp/.env /home/ivpn/entries/user/${vpn_name}
password=`echo -n "${password}" | iconv -t utf16le | openssl md4`

 #echo "${vpn_name} : EAP \"${password}\"" > /home/ivpn/entries/user/${vpn_name}
 echo "${vpn_name} : NTLM \"${password}\"" > /home/ivpn/entries/user/${vpn_name}
 echo "" >> /home/ivpn/entries/user/${vpn_name}
 cp /home/engines/templates/ipsec.secrets.head /etc/ipsec.secrets
 cat /home/ivpn/entries/user/* >> /etc/ipsec.secrets
 chmod go-rwx /etc/ipsec.secrets
}

. /home/engines/functions/params_to_env.sh
params_to_env


required_values="vpn_name password"
check_required_values

    
add_user_vpn
ipsec stroke rereadsecrets

echo "Success"
exit 0
