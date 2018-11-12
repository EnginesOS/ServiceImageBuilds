#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
if test -z $parent_engine
 then
  echo parent_engine cannot be blank
  exit -1
fi

if test -z $service_handle
 then
  echo service_handle cannot be blank
  exit -1
fi
  
cd /var/fs/local/$parent_engine/
engine_path=$service_handle
tar -cpf - $engine_path  |gzip -c


