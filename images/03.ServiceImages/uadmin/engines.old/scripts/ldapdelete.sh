#!/bin/bash

sudo /home/engines/scripts/sudo/_ldapdelete.sh $* 2>&1 > /tmp/ldap.del.out
#if test $ldap_result -eq 0
# then
#  echo '{"Result":"OK","ReturnCode",0}'
#  else
out=`cat /tmp/ldap.del.out`
#   echo  '{"Result":"FAIL","ReturnCode":'$ldap_result':"Output":"'$err'"}'
# fi
#
echo  '{"Result":"OK","ReturnCode":"0"}'
#,"Message":"'$out'"}'