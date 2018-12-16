#!/bin/sh

dbhost=$database_host
dbname=$database_name
dbpasswd=$db_password
dbuser=$db_username
script=$0
Script_Dir=`dirname $0`
Archive=/tmp/big/archive 
cd /tmp
 if test -z $dbname
  then
   echo dbname cant be nill
   exit -1
  fi 
mkdir -p /tmp/big/
cat - > $Archive

$Script_Dir/backup.sh > /tmp/big/backup.sql
  
cat $Script_Dir/drop_tables.sql |  env  PGPASSWORD=$dbpasswd pgsql   -h $dbhost -U $dbuser  $dbname  
  
	

type=`file -i $Archive |grep application/gzip`
if test $? -eq 0
 then
 cat $Archive| gzip -d| env  PGPASSWORD=$dbpasswd psql   -h $dbhost -U $dbuser  $dbname  
 else
 cat $Archive $extract | env  PGPASSWORD=$dbpasswd psql   -h $dbhost -U $dbuser  $dbname  
  fi
 
	if test $? -eq 0
	  then
	   rm  $Archive
	  rm /tmp/big/backup.sql
	   exit 0
	   else
	    cat /tmp/big/backup.sql|  env  PGPASSWORD=$dbpasswd pgsql   -h $dbhost -U $dbuser  $dbname  2> /tmp/roll_back.err
	
	    cat /tmp/roll_back.err >&2
	    echo  Rolled back >&2
	    rm /tmp/big/backup.sql $Archive
	 fi 




