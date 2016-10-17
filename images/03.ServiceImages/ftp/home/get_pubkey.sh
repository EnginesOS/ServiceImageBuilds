#!/bin/sh

if test $1 = 'add' -o $1 = 'rm' -o $1 = 'access'
 then
	if test -f /home/ftpd/.ssh/${1}_rsa.pub
		then
	 		key=`cat /home/ftpd/.ssh/${1}_rsa.pub | awk '{print $2}'`
	 		echo -n $key 	
 		else
 			if ! test -d /home/ftpd/.ssh
 				then
 					mkdir /home/ftpd/.ssh
 				fi
 				
 	 		ssh-keygen  -f /home/ftpd/.ssh/${1}_rsa -P "" > /dev/null
 	 		chown -R proftpd /home/ftpd/.ssh/
 	 		key=`cat /home/ftpd/.ssh/${1}_rsa.pub | awk '{print $2}'`
 	 		echo -n $key 	
 	fi
 fi
 