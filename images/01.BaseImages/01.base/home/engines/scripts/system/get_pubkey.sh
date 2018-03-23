#!/bin/sh

if test -f ~/.ssh/id_rsa.pub
 then
	key=`cat ~/.ssh/id_rsa.pub | awk '{print $2}'`
	echo -n $key	
else 				
 	ssh-keygen  -f ~/.ssh/id_rsa -P "" > /dev/null 	 		
 	key=`cat ~/.ssh/id_rsa.pub | awk '{print $2}'`
 	echo -n $key 	
fi

 exit 0