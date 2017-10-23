#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/grey_listing
parms_to_file_and_env

if ! test -z $grey_list_delay
then
	echo -n $grey_list_delay > /home/engines/scripts/configurators/grey/grey_list_delay
fi
  
if ! test -z $whitelist_addresses
then
	echo $whitelist_addresses > /home/engines/scripts/configurators/grey/white_adresses
else
    truncate --size 0 /home/engines/scripts/configurators/grey/white_adresses
fi

if ! test -z $whitelist_clients
then
	echo $whitelist_clients > /home/engines/scripts/configurators/grey/white_clients
	echo smtp.engines.internal >> /home/engines/scripts/configurators/grey/white_clients
	echo email.engines.internal >> /home/engines/scripts/configurators/grey/white_clients
else
    truncate --size 0 /home/engines/scripts/configurators/grey/white_clients
fi

if ! test -z $enable_grey_listing  
 then
if  test $enable_grey_listing -eq 1
 then
 	touch  /home/engines/scripts/configurators/saved/grey_listing_enabled
 	/home/engines/scripts/email/start_grey.sh
 else
    rm /home/engines/scripts/configurators/saved/grey_listing_enabled
    sudo -n /home/engines/scripts/email/_kill_grey.sh  
  fi 
else
    rm /home/engines/scripts/configurators/saved/grey_listing_enabled
     sudo -n /home/engines/scripts/email/_kill_grey.sh  
fi

sudo /home/engines/scripts/configurators/rebuild_main.sh
   	 
exit 0

   
