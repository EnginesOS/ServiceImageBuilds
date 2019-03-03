#!/bin/bash

cd /home/certs/store/

 for dir in 'pending_csr saved completed_csr imported'
 do
   if ! test -d $dir
    then 
     mkdir -p $dir
   fi
 done

