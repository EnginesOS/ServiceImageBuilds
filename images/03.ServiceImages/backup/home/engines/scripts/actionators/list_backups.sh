#!/bin/sh

echo -n '{"backups":['

if test -d /home/backup/.duply/
 then
  cd  /home/backup/.duply/
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