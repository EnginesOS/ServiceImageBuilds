#!/bin/sh
ca_name=external_ca
. /home/engines/scripts/engine/cert_dirs.sh
n=0
echo '{"pending_csr_list":['
for csr in `ls $pending_csr_dir`
 do
   if test $n -ne 0
      then
       echo ","
   else
    n=1
   fi
   csr=`echo $csr |sed "s/\.csr//"` 
   
  echo '"'$csr'"'
done
echo ']}'
   