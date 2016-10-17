#!/bin/sh

if test $1 = 'add' -o $1 = 'rm' -o $1 = 'access'
 then
	if test -f /home/.ssh/${1}_rsa.pub
		then
	 		cat /home/.ssh/${1}_rsa.pub | awk '{print $2}'	
 		else
 	 		ssh-keygen  -f /home/.ssh/${1}_rsa -P ""
 	 		cat /home/.ssh/${1}_rsa.pub | awk '{print $2}' 	 	
 	fi
 fi
 