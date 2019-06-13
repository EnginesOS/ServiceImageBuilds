#!/bin/sh

cd /home/certs/store/

 for dir in 'pending_csr saved completed_csr imported external_ca/certs external_ca/keys'
 do
   if ! test -d $dir
    then 
     mkdir -p $dir
   fi
 done

