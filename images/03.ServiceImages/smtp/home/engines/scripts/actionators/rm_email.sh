#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="queue_id"
check_required_values 


sudo -n /home/engines/scripts/actionators/_rm_email.sh   $queue_id &> /tmp/err
result=$?
string_for_json=`cat /tmp/err`
rm /tmp/err
string_for_json=`echo $string_for_json | tr -d "'\r\"\t\f\b\n\v"`
if test $result -eq 0
 then
  echo '{"Result":"OK"}'
  else
   echo '{"Result":"FAILED","ReturnCode":"'$result'","Error":"'$string_for_json'"}'
fi 
  
