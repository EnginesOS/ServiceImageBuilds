#!/bin/sh

if test $1 = 'add' -o $1 = 'rm' -o $1 = 'access'
 then
	if test -f /home/ftpd/.ssh/${1}_rsa.pub
		then
	 		cat /home/ftpd/.ssh/${1}_rsa.pub | awk '{print $2}'	
 		else
 			if ! test -d /home/ftpd/.ssh
 				then
 					mkdir /home/ftpd/.ssh
 				fi
 	 		ssh-keygen  -f /home/ftpd/.ssh/${1}_rsa -P "" > /dev/null
 	 		cat /home/ftpd/.ssh/${1}_rsa.pub | awk '{print $2}' 	 	
 	fi
 fi
 