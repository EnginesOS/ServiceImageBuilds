#!/bin/sh


 . /home/engines/functions/checks.sh


if test $# -eq 0 
 then
 	cat -  | ssh -p 2222  -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i ~/.ssh/rm_rsa auth@auth.engines.internal /home/auth/scripts/nfs/rm_service.sh
 else
	echo $1 | ssh -p 2222  -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i ~/.ssh/rm_rsa auth@auth.engines.internal /home/auth/scripts/nfs/rm_service.sh
fi

 