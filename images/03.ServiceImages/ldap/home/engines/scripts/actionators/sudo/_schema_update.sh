#!/bin/sh

required_values="update_id update_data"
check_required_values

if ! test -d  /var/lib/ldap/updates/$update_id
 then
  mkdir -p /var/lib/ldap/updates/$update_id
  echo $update_data >/var/lib/ldap/updates/$update_id/update_data
    
else
 echo already run $update_id
fi 

