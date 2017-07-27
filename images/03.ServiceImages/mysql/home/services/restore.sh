#!/bin/bash

echo $0 $1 $2 >/tmp/called
replace=$1
section=$2

#--replace
if ! test -z $replace
 then
  opts=
fi
if ! test -z $section
 then
 opts="$opts --one-database $section"
 fi
 
echo "cat /tmp/mysql_server/backup.* | mysql -B $opts -h 127.0.0.1 -u rma  2> /tmp/mysqlimport.errs" >/tmp/restore.run
#--delete
rm -fr /tmp/mysql_server
tar -xpf - 2>/tmp/tar.errs

cat /tmp/mysql_server/backup.* | mysql -B $opts -h 127.0.0.1 -u rma 2> /tmp/mysqlimport.errs
if test $? -ne 0
 then 
   cat  /tmp/mysqlimport.errs >&2
	rm -fr /tmp/mysql_server
   exit -1
fi
rm -fr /tmp/mysql_server

mysqladmin -u rma flush-privileges
 
exit 0