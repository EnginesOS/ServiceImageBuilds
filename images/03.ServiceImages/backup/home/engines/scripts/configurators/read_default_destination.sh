#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/default_destination/settings
then
 . /home/engines/scripts/configurators/saved/default_destination/settings
 echo '{"dest_address":"'$dest_address'",
 	"dest_folder":"'$dest_folder'",
 	"dest_pass":"'$dest_pass'",
 	"dest_proto":"'$dest_proto'",
 	"dest_user":"'$dest_user'"}'
else
  echo '{"default_destination":"Not Set"}'
fi

exit 0
