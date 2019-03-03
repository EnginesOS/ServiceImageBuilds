#!/bin/sh

. /home/engines/scripts/engine/backup_dirs.sh

cd $Backup_LogDir
n=0
if test -z $backup_name  
 then
  echo -n '{"backup_logs":['
fi
if test -z $date  
 then
   echo -n '{"backup_logs":['
fi

for log_file in ` ls *_*`
do

if ! test -z $backup_name 
 then
 log_file=`echo $log_file |grep $backup_name`
  if test -z  $log_file
   then
    continue
  fi 
fi

if ! test -z $date 
 then
 log_file=`echo $log_file |grep $date`
   if test -z  $log_file
   then
    continue
  fi 
if ! test -z $backup_name 
 then 
 echo -n '{"backup_name":"'$backup_name'","date":"'$date'","contents":"'
 cp $log_file /tmp/log
 echo -n '"}' >> /tmp/log
 cat /tmp/log | sed ':a;$!{N;s/\n/\\r\\n/;ba;}'
 rm /tmp/log
 exit 0
fi
fi



name=`echo $log_file | sed "/_[0-9][0-9]_.*.log/s///"`
log_date=`echo $log_file | sed "/[_a-z]*_/s///" | sed "/.log/s///"`
if test $n -ne 0
then
 echo -n ","
fi
n=1
echo -n '{"name":"'$name'","date":"'$log_date'"}'

done
 echo ']}'
 