#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

#--replace
#--delete
rm -fr /tmp/mysql_server
tar -xpf - 2>/tmp/tar.errs

cat /tmp/mysql_server/backup.* | mysql -l -h 127.0.0.1 -u rma $section 2> /tmp/mysqlimport.errs
if test $? -ne 0
 then 
   cat  /tmp/mysqlimport.errs >&2
	rm -fr /tmp/mysql_server
   exit -1
fi
rm -fr /tmp/mysql_server
 
 exit 0