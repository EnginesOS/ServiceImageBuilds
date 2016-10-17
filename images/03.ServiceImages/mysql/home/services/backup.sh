#!/bin/bash
dbpasswd=`cat /var/lib/mysql/.pass`
mysqldump -h $dbhost -u rma  --all-databases --single-transaction  |gzip -c 2>/tmp/mysqldump.errs
if test $? -ne 0
 then 
 	cat  /tmp/mysqldump.errs  >&2
 	exit -1
 fi
 
 exit 0