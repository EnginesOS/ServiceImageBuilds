#!/bin/sh

cp /home/tmpl/duply_conf $1
key=`cat /home/backup/.gnupg/key_id`

 if test -z "$key"
 then
  echo "GPG_KEY='disabled'" >> $1
else
  pass=`cat /home/backup/.gnupg/pass`
  echo GPG_KEY=$key >> $1
  echo GPG_PW=$pass >> $1
fi
	
