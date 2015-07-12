#!/bin/bash
pass="pass"

 	#Run First Time on persistent DB
 	
 if ! test -f /var/lib/postgresql/conf
 then
 
 	
	 
	cp -rp /var/lib/postgresql_firstrun/* /var/lib/postgresql/ 

   pass=pass
   /usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf &
   pid=$!
   
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
	  	
touch	/engines/var/run/flags/first_run_done   	 
	 	 
 fi
 	