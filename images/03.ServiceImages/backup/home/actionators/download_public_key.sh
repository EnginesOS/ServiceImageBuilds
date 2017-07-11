#!/bin/bash

if test -f /home/backup/.gnupg/key_created
then
 gpg  --export -a  `cat /home/backup/.gnupg/key_id`
else
 echo "Failed:Key not set"
fi
	

	  