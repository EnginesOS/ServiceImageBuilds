#!/bin/sh

if test $1 = 'add' -o $1 = 'rm' -o $1 = 'access'
 then
	if test -f /home/nfs/.ssh/${1}_rsa.pub
		then
	 		cat /home/nfs/.ssh/${1}_rsa.pub | awk '{print $2}'	
 		else
 			mkdir -p /home/nfs/.ssh/
 	 		ssh-keygen  -f /home/nfs/.ssh/${1}_rsa -P ""> /dev/null
 	 		cat /home/nfs/.ssh/${1}_rsa.pub | awk '{print $2}' 	 	
 	fi
 fi
 
 
 

 