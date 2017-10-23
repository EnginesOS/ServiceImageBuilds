#!/bin/bash
TMP_FILE=`mktemp`
postqueue -j 2> $TMP_FILE.err 1> $TMP_FILE
result=$?

if test $result -ne 0
 then
   string_for_json=`cat $TMP_FILE.err`
   rm /tmp/err
   string_for_json=`echo $string_for_json | tr -d "'\r\"\t\f\b\n\v"`
   echo '{"Result":"FAILED","ReturnCode":"'$result'","Error":"'$string_for_json'"}'
else
  cat $TMP_FILE    
fi 

rm /tmp/$TMP_FILE.err $TMP_FILE