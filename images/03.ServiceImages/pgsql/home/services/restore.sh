#!/bin/bash


cat - | gzip -d | psql

if test $? -ne 0
 then 
    export  PGPASSWORD=''
 	cat  /tmp/pg_sqldump.errs  >&2
 	exit -1
fi
# export  PGPASSWORD=''
 exit 0
