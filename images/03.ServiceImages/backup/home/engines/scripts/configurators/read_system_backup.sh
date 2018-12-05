#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/system_backup
 then
  	  include_logs=`cat /home/engines/scripts/configurators/saved/system_backup/include_logs`
      include_files=`cat /home/engines/scripts/configurators/saved/system_backup/include_files`
      include_services=`cat /home/engines/scripts/configurators/saved/system_backup/include_services`
      include_system=`cat /home/engines/scripts/configurators/saved/system_backup/include_system`
      frequency=`cat /home/engines/scripts/configurators/saved/system_backup/frequency`
      echo '{"include_logs":"'$include_logs'",
      "include_files":"'$include_files'",
      "include_services":"'$include_services'",
      "include_system":"'$include_system'",
      "frequency":"'$frequency'"}'
else
  echo '{"system_backup":"Not Set"}'
fi

exit 0