#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
if test -z $parent_engine
 then
  echo "parent_engine cannot be blank
  exit -1
fi

if test -z $service_handle
 then
  echo "service_handle cannot be blank
  exit -1
fi
  
engine_path=/var/fs/local/$parent_engine/$service_handle
tar -cpf - $engine_path  2>  /tmp/tar.errors.txt |gzip -c

if test $? -ne 0
 then
 cat /tmp/tar.errors.txt >&2
exit -1
 fi
exit 0

