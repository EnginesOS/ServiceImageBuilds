#!/bin/bash
. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z $uid
 then
  echo '{"error":"No ui specified"}'
  exit 127
fi

emails=`ldapsearch -b "ou=People,dc=engines,dc=internal" -LLL -h ldap uid=$uid mailacceptinggeneralid  | grep ^mailacceptinggeneralid: |cut -f2 -d" "`

echo -n '{"addresses":['
n=0
for email in emails
do
 if test $n -ne 0
  then
   echo -n ','
   fi
    n=1
 echo -n '"'$email'"'
done

echo ']}'

 