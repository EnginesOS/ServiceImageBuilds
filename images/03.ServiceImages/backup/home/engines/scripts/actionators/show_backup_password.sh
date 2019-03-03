#!/bin/sh
. /home/engines/scripts/engine/bacup_dirs.sh

pass=`cat /home/backup/.gnupg/pass`
echo '{"backup_password":"'$pass'"}'

	
	  