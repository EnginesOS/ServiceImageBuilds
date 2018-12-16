#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/ca_saved
 then 
  . /home/engines/scripts/configurators/saved/ca_saved
  echo '{
   "person":"'$person'",
   "organisation":"'$organisation'",
   "city":"'$city'",
   "state":"'$state'",
   "country":"'$country'",
   "domain_name":'$domain_name'"}'
  else
   echo '{"CA":"Not set"}'
 fi
