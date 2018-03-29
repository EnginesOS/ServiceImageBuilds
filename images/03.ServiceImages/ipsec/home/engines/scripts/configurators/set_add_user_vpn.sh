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

    
add_user_vpn

sudo -n /home/engines/scripts/configurators/_add_user_vpn.sh
echo "Success"
exit 0
