#!/bin/sh

 . /home/engines/functions/checks.sh
if test ca_name = system
 then
  echo '{"status":"error","message":"Cannot overwrite System CA"}'
  exit 2
 fi 

required_values="domain_name ca_name"
check_required_values

/home/engines/scripts/engine/create_ca.sh

 
