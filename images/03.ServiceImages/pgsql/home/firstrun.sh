#!/bin/bash

pass=`dd if=/dev/urandom count=6 bs=1  | od -h | awk '{ print $2$3$4}'`
 	#Run First Time on persistent DB
 	
mkdir /var/run/postgresql/
 	
 if ! test -f /var/lib/postgresql/conf
 then
	cp -rp /var/lib/postgresql_firstrun/* /var/lib/postgresql/ 
   /usr/lib/postgresql/9.5/bin/postgres -D /var/lib/postgresql/9.5/main -c config_file=/etc/postgresql/9.5/main/postgresql.conf &
   pid=$!

   echo "*:*:*:root:$pass" > /var/lib/postgresql/.pass
   cp /var/lib/postgresql/.pass /home/postgres/.pgpass
   chmod 600 /home/postgres/.pgpass /var/lib/postgresql/.pass
 	touch /var/lib/postgresql/conf 	
 #	psql template1 -c 'create extension hstore;'
	 echo "ALTER ROLE postgres WITH ENCRYPTED PASSWORD '$pass'; " > /tmp/t.sql
	 echo "create ROLE rma WITH ENCRYPTED PASSWORD '$pass'; " >> /tmp/t.sql
	 echo "Alter ROLE rma WITH superuser;" >> /tmp/t.sql
	 echo "Alter ROLE rma WITH   login;" >> /tmp/t.sql
	 echo "CREATE DATABASE rma OWNER = rma ;" >> /tmp/t.sql
	 psql </tmp/t.sql	 
	 kill -TERM $pid
	 wait $pid	  	
     touch /engines/var/run/flags/first_run_done   	 	 	 
 fi
 	