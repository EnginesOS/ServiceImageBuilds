#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="parent_engine container_type owner"
check_required_values
export parent_engine container_type owner
err_log=`mktemp`
sudo -n /home/engines/scripts/services/_add_service.sh &> $err_log
r=$?
if test $r -ne 0
 then
  echo -n "Failed:"
  cat $err_log  
else
 echo "Success"
fi
rm $err_log
exit  $r

