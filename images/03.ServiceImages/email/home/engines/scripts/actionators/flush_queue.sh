#!/bin/sh
perr=`mktemp`
postqueue -f 2>&1 > $perr
result=$?
string_for_json=`cat $perr`
rm $perr
string_for_json=`echo $string_for_json | tr -d "'\r\"\t\f\b\n\v"`
if test $result -eq 0
 then
  echo '{"Result":"OK"}'
  else
   echo '{"Result":"FAILED","ReturnCode":"'$result'","Error":"'$string_for_json'"}'
  
  fi 
