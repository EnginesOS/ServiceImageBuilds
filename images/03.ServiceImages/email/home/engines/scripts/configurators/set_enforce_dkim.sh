#!/bin/sh

if test $enforce_dkim = true
 then
  touch /home/engines/scripts/configurators/saved/enforce_dkim
elif test -f /home/engines/scripts/configurators/saved/enforce_dkim
  then
   rm /home/engines/scripts/configurators/saved/enforce_dkim
fi

sudo -n /home/engines/scripts/configurators/sudo/rebuild_main.sh

exit 0
