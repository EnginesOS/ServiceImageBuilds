#!/bin/bash
cd /tmp
cat - | tar -xpf - dump
passwd=`cat  /data/db/.priv/db_master_pass
cd dump
mongorestore  -h mongo --password $passwd -u admin  --oplog  2>/tmp/mongorestore.errs
if test $? -ne 0
 then 
 	cat  /tmp/mongodump.errs  >&2
 	exit -1
 fi

rm -r dump
exit 0
