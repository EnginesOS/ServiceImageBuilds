#!/bin/bash


service_hash=`echo  "$1" | sed "/\*/s//STAR/g"`
. /home/engines/scripts/functions.sh

load_service_hash_to_environment

#FIXME make engines.internal settable


echo "Success"
exit 0

