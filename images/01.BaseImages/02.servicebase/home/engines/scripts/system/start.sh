#!/bin/sh

if ! test -f /home/engines/run/flags/ca-update
 then
   sudo -n /home/engines/scripts/system/_update_ca.sh		
fi

exec /home/engines/scripts/startup/start.sh
