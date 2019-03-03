#!/bin/sh
. /home/engines/scripts/engine/bacup_dirs.sh


if test -f /home/backup/.gnupg/key_created
then
 gpg --export-secret-key -a `cat /home/backup/.gnupg/key_id`
else
 echo "Failed:Key not set"
fi
	
	  