#!/bin/bash
rm -fr /tmp/mysql_server
tar -xpf - 2>/tmp/tar.errs

cat /tmp/mysql_server/backup.* | mysql -h 127.0.0.1 -u rma 2> /tmp/mysqlimport.errs
if test $? -ne 0
 then 
   cat  /tmp/mysqlimport.errs >&2
rm -fr /tmp/mysql_server
   exit -1
fi
rm -fr /tmp/mysql_server
 
 exit 0