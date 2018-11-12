#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
dbhost=$database_host
dbname=$database_name
dbpasswd=$db_password
dbuser=$db_username
export  PGPASSWORD=$dbpasswd
 if test -z $dbname
  then
   echo dbname cant be nill
   exit -1
  fi 
pg_dump  -h $dbhost -Fc -U $dbuser  $dbname 2>/tmp/pg_sqldump.errs |gzip -c 
export  PGPASSWORD=''
if test $? -ne 0
 then 
 	cat  /tmp/pg_sqldump.errs  >&2
 	exit -1
 fi
 
 exit 0