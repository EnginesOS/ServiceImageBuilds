#!/bin/sh

echo -n '{"backup_running":'

if test -f /home/engines/run/flags/backup_run
 then 
  echo -n '"yes"'
 else
   echo -n '"no"'
fi

echo -n ',"restore_running":' 

if test -f /home/engines/run/flags/restore
 then 
  echo -n '"yes"'
 else
   echo -n '"no"'
fi
if test -f /home/engines/run/flags/current_backup
 then
current_backup=`cat /home/engines/run/flags/current_backup`
if test -z current_backup
 then 
  current_backup=none
fi
fi
if test -f /home/engines/run/flags/current_operation
 then
current_operation=`cat /home/engines/run/flags/current_operation`
if test -z current_operation
 then 
  current_operation=none
fi
fi

echo -n ',"current_backup":"'$current_backup
echo -n '","current_operation":"'$current_operation
echo -n '"}'

