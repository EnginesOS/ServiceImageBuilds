#!/bin/bash


sudo /home/engines/scripts/sudo/_ldapmodify.sh $* 2>&1 > /tmp/ldap.mod.out
#if test $ldap_result -eq 0
# then
#  echo '{"Result":"OK","ReturnCode",0}'
#  else
out=`cat /tmp/ldap.mod.out`
#   echo  '{"Result":"FAIL","ReturnCode":'$ldap_result':"Output":"'$err'"}'
# fi

echo  '{"Result":"OK","ReturnCode":"0"}'
#,"Message":"'$out'"}'
