#!/bin/sh

	if test -f ~/.ssh/id_rsa.pub
		then
	 		cat ~/.ssh/id_rsa.pub | awk '{print $2}'	
 		else 				
 	 		ssh-keygen  -f ~/.ssh/id_rsa -P "" > /dev/null 	 		
 	 		cat ~/.ssh/id_rsa.pub | awk '{print $2}' 	 	
 	fi

 