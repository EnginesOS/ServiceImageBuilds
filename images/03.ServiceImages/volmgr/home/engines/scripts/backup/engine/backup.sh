#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

tar -cpf - $engine_path |gzip -c 2>  /tmp/tar.errors.txt

if test $? -ne 0
 then
 cat /tmp/tar.errors.txt >&2
exit -1
 fi
exit 0

