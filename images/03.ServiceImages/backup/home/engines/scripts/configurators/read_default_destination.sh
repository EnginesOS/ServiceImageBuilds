#!/bin/sh


if test -d /home/engines/scripts/configurators/saved/default_destination
then
. /home/engines/scripts/configurators/saved/default_destination/settings
 echo '{"default_destination":
 	{"dest_address":"'$dest_address'",
 	"dest_folder":"'$dest_folder'",
 	"dest_pass":"'$dest_pass'",
 	"dest_proto":"'$dest_proto'",
 	"dest_user":"'$dest_user'"}}'
else
  echo '{"default_destination":"Not Set"}'
fi

exit 0