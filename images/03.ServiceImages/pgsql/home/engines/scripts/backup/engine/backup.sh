#!/bin/sh

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
pg_dump  -h $dbhost -Fc -U $dbuser  $dbname  |gzip -c 
export  PGPASSWORD=''
