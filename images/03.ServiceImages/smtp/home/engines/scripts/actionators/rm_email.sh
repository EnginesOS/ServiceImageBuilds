#!/bin/sh

 . /home/engines/functions/checks.sh
required_values="queue_id"
check_required_values 

rf=`mktemp`
sudo -n /home/engines/scripts/actionators/sudo/_rm_email.sh   $queue_id &> $rf
result=$?
string_for_json=`cat $rf`
rm $rf
string_for_json=`echo $string_for_json | tr -d "'\r\"\t\f\b\n\v"`
if test $result -eq 0
 then
  echo '{"Result":"OK"}'
  else
   echo '{"Result":"FAILED","ReturnCode":"'$result'","Error":"'$string_for_json'"}'
fi 
  
