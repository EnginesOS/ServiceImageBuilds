#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
export  PGPASSWORD=$dbpasswd
 if test -z $dbname
  then
   echo dbname cant be nill
   exit -1
  fi 
pg_dump  -h $dbhost -Fc -U $dbuser  $dbname |gzip -c 2>/tmp/pg_sqldump.errs
export  PGPASSWORD=''
if test $? -ne 0
 then 
 	cat  /tmp/pg_sqldump.errs  >&2
 	exit -1
 fi
 
 exit 0