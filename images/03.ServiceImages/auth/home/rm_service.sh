#!/bin/bash


. /home/engines/functions/params_to_env.sh
params_to_env

if test -z $service 
	then
	echo "Error service not set"
		exit -1
	fi	


echo "Success"
exit 0
