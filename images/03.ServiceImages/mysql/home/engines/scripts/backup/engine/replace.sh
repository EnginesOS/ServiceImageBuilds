#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

script=$0
Script_Dir=`dirname $0`
Archive=/tmp/big/archive 
cd /tmp
mkdir -p /tmp/big/
cat - > $Archive

$Script_Dir/backup.sh > /tmp/big/backup.sql
   if test -z $dbname
  then
   echo dbname cant be nill
   exit -1
   fi
#cat $Script_Dir/drop_tables.sql | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 2> /tmp/extract.err
echo " SET FOREIGN_KEY_CHECKS = 0;" | mysql  -h $dbhost -u $dbuser --password=$dbpasswd  $dbname
mysql  -h $dbhost -u $dbuser --password=$dbpasswd  --silent --skip-column-names -e "SHOW TABLES" $dbname | xargs -L1 -I% echo 'DROP TABLE `%`;' | mysql -v $dbname
echo " SET FOREIGN_KEY_CHECKS = 1;" | mysql  -h $dbhost -u $dbuser --password=$dbpasswd  $dbname

type=`file -i $Archive |grep application/gzip`
if test $? -eq 0
 then
 cat $Archive| gzip -d| mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 2> /tmp/extract.err
 else
 cat $Archive $extract | mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 2> /tmp/extract.err
  fi

	if test $? -eq 0
	  then
	   rm  $Archive
	  rm /tmp/big/backup.sql
	   exit 0
	   else
	    cat /tmp/big/backup.sql| mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname 2> /tmp/roll_back.err
	    cat  /tmp/extract.err
	    cat /tmp/roll_back.err
	    echo  Rolled back >&2
	    rm /tmp/big/backup.sql $Archive
	    exit 127
	 fi 




