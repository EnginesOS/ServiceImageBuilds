#!/bin/bash

service_hash=`cat -`

cat - >/home/configurators/saved/grey_listing
cat /home/configurators/saved/grey_listing | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


 
if ! test -z $grey_list_delay
then
	echo -n $grey_list_delay > /home/configurators/grey/grey_list_delay
  fi
  
if ! test -z $whitelist_addresses
then
	echo $whitelist_addresses > /home/configurators/grey/white_adresses
else
 truncate --size 0 /home/configurators/grey/white_adresses
  fi

if ! test -z $whitelist_clients
then
	echo $whitelist_clients > /home/configurators/grey/white_clients
	echo smtp.engines.internal >> /home/configurators/grey/white_clients
	echo email.engines.internal >> /home/configurators/grey/white_clients
else
 truncate --size 0 /home/configurators/grey/white_clients
  fi


if  test $enable_grey_listing -eq 1
 then
 	touch  /home/configurators/saved/grey_listing_enabled
 	/home/start_grey.sh
 else
     rm  /home/configurators/saved/grey_listing_enabled
    sudo /home/kill_grey.sh  
  fi    



sudo /home/configurators/rebuild_main.sh
   	
 
exit 0

   
