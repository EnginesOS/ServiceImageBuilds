#!/bin/bash


if test $# -eq 0 
 then
 	cat -  |  ssh -p 2222  -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i /home/ftpd/.ssh/rm_rsa auth@auth.engines.internal /home/auth/scripts/ftp/rm_service.sh 
 else
	echo $1 | ssh -p 2222  -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i /home/ftpd/.ssh/rm_rsa auth@auth.engines.internal /home/auth/scripts/ftp/rm_service.sh 
fi

 