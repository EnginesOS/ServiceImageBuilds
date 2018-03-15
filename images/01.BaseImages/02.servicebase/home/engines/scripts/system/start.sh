#!/bin/sh

if ! test -w /home/engines/run
 then
  sudo -n /home/engines/scripts/system/_set_rundir_perms.sh
fi  

if ! test -f /home/engines/run/flags/ca-update
 then
   sudo -n /home/engines/scripts/system/_update_ca.sh		
fi

sudo -n /home/engines/scripts/system/_setup_logging.sh		

exec /home/engines/scripts/startup/start.sh
