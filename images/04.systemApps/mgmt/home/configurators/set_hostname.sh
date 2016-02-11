#!/bin/bash
service_hash=$1

echo $1 >/home/configurators/saved/hostname

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


if test -z ${hostname} 
	then  
	 echo "Error: Missing hostname"
	  exit 128
fi


if  test -z ${domain_name} 
	then  
		 echo "Error: Missing domain_name"
	  exit 128
fi
/opt/engines/scripts/set_hostname.sh $hostname.$domain_name
exit 0