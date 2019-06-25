#!/bin/sh
. /home/engines/scripts/engine/backup_dirs.sh

echo -n '{"backups":['

if test -d $Backup_ConfigDir/
 then
  cd  $Backup_ConfigDir/
  backups=`find . -type d |grep / |sed "/\.\//s///"`
  n=0
   if ! test -z "$backups"
    then  
     for backup in $backups
      do
       if test $n == 0
        then 
          n=2
       else
          echo -n ','
       fi
      echo -n '"'$backup'"'
     done
   fi
fi
echo ']}'
