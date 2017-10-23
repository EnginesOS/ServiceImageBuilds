#!/bin/bash

postqueue -f &> /tmp/err
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
