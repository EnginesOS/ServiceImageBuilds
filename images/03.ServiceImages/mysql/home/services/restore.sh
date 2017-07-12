#!/bin/bash

tar -xzpf - 2>/tmp/tar.errs

cat /tmp/mysql_server/backup.*gz |gzip -d | mysql -h 127.0.0.1 -u rma 2> /tmp/mysqlimport.errs
if test $? -ne 0
 then 
   cat  /tmp/mysqlimport.errs >&2
   exit -1
fi
 
 exit 0