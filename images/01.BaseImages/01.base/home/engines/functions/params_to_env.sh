#!/bin/sh
function params_to_env
{
env_file=`mktemp`
if test $# -eq 0 
 then
 	cat - | /home/engines/bin/json_to_env >$env_file
 else
	echo $1 | /home/engines/bin/json_to_env >$env_file
fi

. $env_file
rm $env_file
}

function params_to_file_and_env
{
env_file=`mktemp`
cat - > $PARAMS_FILE
cat $PARAMS_FILE | /home/engines/bin/json_to_env >$env_file
. $env_file
rm $env_file
}

function check_required_values {
for val in $required_values 
 do
   value=`eval echo \\$${key}`
    if test -z "$value"
     then
       echo Abort no value receieved for $key
       exit 127
    fi
done

}