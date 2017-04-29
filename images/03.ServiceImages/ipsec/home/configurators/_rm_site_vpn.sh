#!/bin/bash


function rm_site_vpn {
if ! test -f /home/ivpn/entries/site/${vpn_name}
 then
 echo "No Such VPN ${vpn_name}"
 fi
 
rm /home/ivpn/entries/site/${vpn_name}

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

    



		rm_site_vpn

	


echo "Success"
exit 0
