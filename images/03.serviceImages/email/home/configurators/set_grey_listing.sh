#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/grey_listing
 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if  test $enable_grey_listing -eq 1
 then
 	touch  /home/configurators/saved/grey_listing_enabled
 else
     rm  /home/configurators/saved/grey_listing_enabled
  fi    

sudo /home/configurators/rebuild_main.sh
   	
 
exit 0
