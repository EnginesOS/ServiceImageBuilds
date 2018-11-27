#!/bin/sh



 . /home/engines/functions/checks.sh
 
if test $# -eq 0 
 then
 	cat -  |  ssh -p 2222  -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i /home/nfs/.ssh/add_rsa auth@auth.engines.internal /home/auth/scripts/nfs/add_service.sh 
 else ssh -p 2222  -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i /home/nfs/.ssh/add_rsa auth@auth.engines.internal /home/auth/scripts/nfs/add_service.sh 
	echo $1 | 
fi

 . /tmp/.env


