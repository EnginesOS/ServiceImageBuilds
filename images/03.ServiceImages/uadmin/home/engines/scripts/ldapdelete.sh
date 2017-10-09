#/bin/bash

sudo /home/engines/scripts/sudo/_ldapdelete.sh $* &> /tmp/ldap.add.out
#if test $ldap_result -eq 0
# then
#  echo '{"Result":"OK","ReturnCode",0}'
#  else
out=`cat /tmp/ldap.add.out`
#   echo  '{"Result":"FAIL","ReturnCode":'$ldap_result':"Output":"'$err'"}'
# fi
#
echo  '{"Result":"OK","ReturnCode":0,"Message":"'$out'"}'