#!/bin/bash

function add_user_vpn {
cp /tmp/.env /home/ivpn/entries/user/${vpn_name}
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
	



echo "Success"
exit 0
