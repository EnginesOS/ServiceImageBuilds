#!/bin/bash

tar -xpf -  2>/tmp/tar.errs

cat /tmp/pgsqld/backup.* | psql 

if test $? -ne 0
 then 
    export  PGPASSWORD=''
 
 	exit -1
fi
# export  PGPASSWORD=''
 exit 0
