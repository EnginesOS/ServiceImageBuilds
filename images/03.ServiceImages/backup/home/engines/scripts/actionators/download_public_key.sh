#!/bin/sh
. /home/engines/scripts/engine/backup_dirs.sh


if test -f /home/backup/.gnupg/key_created
then
 gpg --export -a `cat /home/backup/.gnupg/key_id`
else
  echo '{"status":"error","message":"Failed:Key not set"}'
 exit 2
fi
	

	  