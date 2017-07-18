#!/bin/bash
passwd=`cat  /data/db/.priv/db_master_pass
cd /tmp
mongodump  -h mongo --password $passwd -u admin  --oplog  2>/tmp/mongodump.errs
if test $? -ne 0
 then 
 	cat  /tmp/mongodump.errs  >&2
 	exit -1
 fi
tar -cpf - dump |gzip -c
rm -r dump
exit 0