#!/bin/sh


if test -z $queue_id
 then
  echo '{"Result":"Failed","ErrorMesg","Missing queueid"}'
  exit 127
fi

perr=`mktemp`
sudo -n /home/engines/scripts/actionators/sudo/_rm_email.sh   $queue_id &>  $perr
result=$?
string_for_json=`cat  $perr`
rm  $perr
string_for_json=`echo $string_for_json | tr -d "'\r\"\t\f\b\n\v"`
if test $result -eq 0
 then
  echo '{"Result":"OK"}'
  else
   echo '{"Result":"FAILED","ReturnCode":"'$result'","Error":"'$string_for_json'"}'
fi 
  
