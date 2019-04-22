#!/bin/sh
. /home/engines/scripts/engine/backup_dirs.sh

pass=`cat /home/backup/.gnupg/pass`
echo '{"backup_password":"'$pass'"}'

	
	  