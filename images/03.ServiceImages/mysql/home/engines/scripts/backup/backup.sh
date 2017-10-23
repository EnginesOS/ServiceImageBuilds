#!/bin/bash
#dbpasswd=`cat /var/lib/mysql/.pass`
mysqldump -h 127.0.0.1 -u rma  --all-databases --single-transaction   2>/tmp/mysqldump.errs
if test $? -ne 0
 then 
   cat  /tmp/mysqldump.errs  >&2
   exit -1
fi
 
 exit 0