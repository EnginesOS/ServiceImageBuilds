#!/bin/sh

mysql -h $dbhost -u $dbuser --password=$dbpasswd $dbname < /home/auth/create_tables.sql

if test -f /home/home_dir/.ssh/krb.pass
 then 
  pass=`cat /home/home_dir/.ssh/krb.pass`
else
  pass=`dd if=/dev/urandom count=12 bs=1  | od -h | awk '{ print $2$3$4$5$6}'`
  echo pass > /home/home_dir/.ssh/krb.pass
  chmod og-rwx /home/home_dir/.ssh/krb.pass
fi

export pass 
expect /home/auth/kerobos_init.expect

