#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
required_values="uid password"
check_required_values 

. /home/engines/functions/ldap/support_functions.sh
 err_file=`mktemp`
 echo "cpw -pw $password  $uid" | sudo -n /home/engines/scripts/actionators/sudo/_add_kerberos_princ.sh >& $err_file
 if test $e -eq 0
 then
   echo '{"Result":"OK","Code":"200"}'
 else
   err=`cat $err_file`
   echo '{"Error":"failed to change user","Result":"Failed $err","exit":"'$e'"}'   
 fi
 rm $err