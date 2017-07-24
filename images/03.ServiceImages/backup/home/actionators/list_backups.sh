#!/bin/bash
cd  /home/backup/.duply/
backups=`find . -type d |grep / |sed "/\.\//s///"`

echo -n '{"backups":['
n=0

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

echo ']}'