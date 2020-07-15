#!/bin/sh

. /home/engines/functions/checks.sh

#. /home/engines/functions/params_to_env.sh
#params_to_env

required_values="parent_engine container_type"
check_required_values
export parent_engine container_type
err_log=`mktemp`
sudo -n /home/engines/scripts/services/_rm_service.sh 2>&1 > $err_log
r=$?
if test $r -ne 0
 then
  echo -n "Failed:"
  cat $err_log  
else
 echo "Success"
fi
rm $err_log
exit $r
