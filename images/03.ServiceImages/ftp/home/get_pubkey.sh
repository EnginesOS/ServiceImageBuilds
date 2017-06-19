#!/bin/sh

if test $1 = 'add' -o $1 = 'rm' -o $1 = 'access'
 then
	if test -f /home/home_dir/.ssh/${1}_rsa.pub
	 then
	   key=`cat /home/home_dir/.ssh/${1}_rsa.pub | awk '{print $2}'`
	   echo -n $key 	
 	else
 		if ! test -d /home/home_dir/.ssh/
 		  then
 			mkdir /home/home_dir/.ssh/
 		fi 			
 	 ssh-keygen  -f /home/home_dir/.ssh/${1}_rsa -P "" > /dev/null
 	 chown -R proftpd /home/home_dir/.ssh/*
 	 chmod og-rw proftpd /home/home_dir/.ssh/*
 	 key=`cat /home/home_dir/.ssh/${1}_rsa.pub | awk '{print $2}'`
 	 echo -n $key 	
 	fi
 fi
 