#!/bin/sh

if test -f /tmp/mysqld.cnf
 then
   if ! test -f /home/engines/run/flags/oringnal_mysqld.cnf
    then
      cp /etc/mysql/mysql.conf.d/mysqld.cnf /home/engines/run/flags/oringnal_mysqld.cnf 
   fi   
   rm /etc/mysql/mysql.conf.d/mysqld.cnf
   mv /tmp/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
fi
