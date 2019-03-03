#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
n=0
echo '{"pending_csr_list":['
for csr in `ls $pending_csr_dir`
 do
   if test $n -eq 0
      then
       echo ","
   fi
   csr=`echo $csr |sed "s/\.csr//"` 
   
  echo '"'$csr'"'
done
echo ']}'
   