#!/bin/bash
cd /tmp
cat - | tar -xpf - dump
passwd=`cat  /data/db/.priv/db_master_pass
cd dump
mongorestore  -h mongo --password $passwd -u admin  --oplog 
if test $? -ne 0
 then 
 	exit -1
 fi

rm -r dump
exit 0
