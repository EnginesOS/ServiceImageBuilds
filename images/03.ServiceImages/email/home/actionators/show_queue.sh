#!/bin/bash

postqueue -j 2> /tmp/err
result=$?
string_for_json=`cat /tmp/err`
rm /tmp/err
string_for_json=`echo $string_for_json | tr -d "'\r\"\t\f\b\n\v"`
if test $result -ne 0
 then
   echo '{"Result":"FAILED","ReturnCode":"'$result'","Error":"'$string_for_json'"}'  
  fi 