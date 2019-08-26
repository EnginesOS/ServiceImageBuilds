#!/bin/sh
passwd=`cat  /data/db/.priv/db_master_pass`
cd /tmp
mongodump  -h mongo --password $passwd -u admin  --oplog 
if test $? -ne 0
 then 
 	exit -1
 fi
tar -cpf - dump 
rm -r dump
exit 0