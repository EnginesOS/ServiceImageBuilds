#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/system_backup
 then
  cat /home/engines/scripts/configurators/saved/system_backup
else
  echo '{"system_backup":"Not Set"}'
fi

exit 0