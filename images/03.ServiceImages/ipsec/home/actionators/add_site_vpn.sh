#!/bin/bash


function add_site_vpn {
cp /tmp/.env /home/ivpn/entries/site/${vpn_name}
}
if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env>/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env


	if test -z "${vpn_name}" 
	then
		echo Error:Missing Username
        exit -1
    fi
    if test -z "${remote_site}" 
	then
		echo Error:Missing Remote Site
        exit -1
    fi
       if test -z "${remote_lan}" 
	then
		echo Error:Missing Remote Lan
        exit -1
    fi
     if test -z "${remote_id}" 
	then
		echo Error:Missing Remote id
        exit -1
    fi

    
add_site_vpn


echo "Success"
exit 0
