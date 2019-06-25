#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/system_backup/settings
 then
  		. /home/engines/scripts/configurators/saved/system_backup/settings     	  
      echo '{"include_logs":"'$include_logs'",
      "include_files":"'$include_files'",
      "include_services":"'$include_services'",
      "include_system":"'$include_system'",
      "frequency":"'$frequency'"}'
else
  echo '{"system_backup":"Not Set"}'
fi

exit 0
