#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

 if test -z $dbname
  then
   echo dbname cant be nill
   exit -1
   fi
Archive=/tmp/big/archive 
cd /tmp
mkdir -p /tmp/big/
cat - > $Archive



type=`file -i $Archive |grep application/gzip`
if test $? -eq 0
 then
 cat $Archive| gzip -d| mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 2> /tmp/extract.err
 else
 cat $Archive | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 2> /tmp/extract.err
  fi

	if test $? -eq 0
	  then
	   rm  $Archive 
	  
	   exit 0
	   else
	
	    cat  /tmp/extract.err
	    echo  Rolled back >&2
	  #  rm  $Archive 
	    exit 127
	 fi 




