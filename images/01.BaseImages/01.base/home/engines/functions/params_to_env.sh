#!/bin/sh
function params_to_env
{
if test $# -eq 0 
 then
 	cat - | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

. /tmp/.env
rm /tmp/.env
}

function parms_to_file_and_env
{
cat - > $PARAMS_FILE
cat $PARAMS_FILE | /home/engines/bin/json_to_env >/tmp/.env
. /tmp/.env
rm /tmp/.env
}