#!/bin/bash

tar -xpf -  2>/tmp/tar.errs

cat /tmp/pgsql_server/backup.*gz | gzip -d | psql 2>tmp/pg_sqlimport.errs

if test $? -ne 0
 then 
    export  PGPASSWORD=''
 	cat  /tmp/pg_sqlimport.errs  >&2
 	exit -1
fi
# export  PGPASSWORD=''
 exit 0
