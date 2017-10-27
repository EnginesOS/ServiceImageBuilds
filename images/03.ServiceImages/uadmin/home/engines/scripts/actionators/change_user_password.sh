#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

. /home/engines/functions/ldap/support_functions.sh

 echo "cpw -pw $password  $uid" | sudo -n /home/engines/scripts/actionators/sudo/_add_kerberos_princ.sh
 if test $e -eq 0
 then
   echo '{"Result":"OK","Code":"200"}'
 else
   echo '{"Error":"failed to del k user","Result":"Failed","exit":"'$e'"}'   
 fi