#!/bin/bash

function add_user_vpn {
#cp /tmp/.env /home/ivpn/entries/user/${vpn_name}
 echo "${vpn_name} : EAP  \"${password}\"" > /home/ivpn/entries/user/${vpn_name}
 echo "" >> /home/ivpn/entries/user/${vpn_name}
 cp /home/ipsec.secrets.head /etc/ipsec.secrets
 cat /home/ivpn/entries/user/* >> /etc/ipsec.secrets
 chmod go-rwx /etc/ipsec.secrets
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
   echo Error:Missing Username
   exit -1
fi

if test -z "${password}"
 then
   echo Error:Missing Password
   exit -1
fi
    
add_user_vpn
ipsec stroke rereadsecrets

echo "Success"
exit 0
