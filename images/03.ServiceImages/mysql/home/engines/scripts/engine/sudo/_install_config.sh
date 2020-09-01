#!/bin/sh

if test -f /tmp/mysqld.cnf
 then
   rm /etc/mysql/mysql.conf.d/mysqld.cnf
   mv /tmp/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
fi
