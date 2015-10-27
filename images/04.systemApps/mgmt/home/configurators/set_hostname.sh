#/bin/bash
service_hash=$1

echo $1 >/home/configurators/saved/hostname

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

if test -z ${hostname} 
	then  
	 echo "Error: Missing hostname"
fi

/opt/engines/scripts/set_hostname.sh $hostname

if ! test -z ${domain_name} 
	then  
		/opt/engines/scripts/set_domain_name.sh $domain_name
fi

exit 0