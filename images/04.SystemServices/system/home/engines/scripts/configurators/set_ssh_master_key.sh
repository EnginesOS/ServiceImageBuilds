#!/bin/sh

 . /home/engines/functions/checks.sh

    
   	if test -n $ssh_master_key
	then  
	 echo ssh-rsa  $ssh_master_key engines  > /home/engines/.ssh/authorized_keys
		
 	fi
 

