#!/bin/sh

dbhost=$database_host
dbname=$database_name
dbpasswd=$db_password
dbuser=$db_username

Archive=/tmp/big/archive 
cd /tmp
 if test -z $dbname
  then
   echo dbname cant be nill
   exit -1
  fi 
mkdir -p /tmp/big/
cat - > $Archive



type=`file -i $Archive |grep application/gzip`
if test $? -eq 0
 then
 cat $Archive| gzip -d| env  PGPASSWORD=$dbpasswd psql   -h $dbhost -U $dbuser  $dbname 
 else
 cat $Archive | env  PGPASSWORD=$dbpasswd psql   -h $dbhost -U $dbuser  $dbname  
  fi
	
	if test $? -eq 0
	  then
	   rm  $Archive 
	 
	   exit 0
	   else
	    echo  Rolled back >&2
	    rm  $Archive	   
	 fi 




