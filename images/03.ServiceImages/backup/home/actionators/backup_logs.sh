#!/bin/bash

cd /var/log/

for log_file in ` ls *_*`
do

if ! test -z $backup_name 
 then
 log_file=`echo $log_file |grep $backup_name` 
fi

if ! test -z $date 
 then
 log_file=`echo $log_file |grep $date`
 cat $log_file
 exit 0
else
 echo  $log_file
fi

done
 
 