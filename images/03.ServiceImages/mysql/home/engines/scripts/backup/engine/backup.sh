#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
 
 if test -z $dbname
  then
   echo dbname cant be nill
   exit -1
  fi 
mysqldump -h $dbhost -u $dbuser --password=$dbpasswd $dbname 2>/tmp/mysqldump.errs
if test $? -ne 0
 then 
 	cat  /tmp/mysqldump.errs  >&2
 	exit -1
 fi
 
 exit 0