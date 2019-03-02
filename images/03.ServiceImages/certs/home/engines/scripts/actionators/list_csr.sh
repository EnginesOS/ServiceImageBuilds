#!/bin/sh
. /home/engines/scripts/engine/certs_dirs.sh

echo '{"pending_csr_list":['
for csr in `ls $pending_csr_dir`
 do
   if test $n -eq 0
      then
       echo ","
   fi
  echo '"'$csr'"'
done
echo ']}'
    