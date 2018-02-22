#!/bin/bash
service_hash=$1

echo $1 >/home/engines/scripts/configurators/saved/hostname

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


if test -z ${hostname} 
	then  
	 echo "Error: Missing hostname"
	  exit 128
fi


if  test -z ${domain_name} 
	then  
	hostname=`echo $hostname | cut -f 1 -d.`
	domain_name=`echo $hostname | cut -f 2- -d.`
	fi
if  test -z ${domain_name} 
	then	
		 echo "Error: Missing domain_name"
	  exit 128
fi
/opt/engines/system/scripts/system/set_hostname.sh $hostname.$domain_name
exit 0