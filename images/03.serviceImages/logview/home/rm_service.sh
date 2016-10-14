#!/bin/bash
if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env >/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env


rm /home/saved/$parent_engine/$log_name 
/home/build_config.sh
