#!/bin/bash



if  test -f /home/configurators/saved/grey_listing_enabled
 then
 	enable_grey_listing=true
 else
   enable_grey_listing=false
  fi    

echo "{\"enable_grey_listing\":\"$enable_grey_listing\"}"
   	
 
exit 0
