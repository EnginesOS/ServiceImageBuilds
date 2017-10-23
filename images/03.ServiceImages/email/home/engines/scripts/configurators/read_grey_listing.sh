#!/bin/bash



if  test -f /home/engines/scripts/configurators/saved/grey_listing_enabled
 then
 	enable_grey_listing=true
 	grey_list_delay=`cat /home/engines/scripts/configurators/grey/grey_list_delay`
 	whitelist_addresses=`cat /home/engines/scripts/configurators/grey/white_adresses`
 	whitelist_clients=`cat/home/engines/scripts/configurators/grey/white_clients `
 else
   enable_grey_listing=false
fi    

echo "{\"enable_grey_listing\":\"$enable_grey_listing\",\"grey_list_delay\":\"$grey_list_delay\",\"whitelist_clients\":\"$whitelist_clients\",\"whitelist_addresses\":\"$whitelist_addresses\"}"
   	
 
exit 0
