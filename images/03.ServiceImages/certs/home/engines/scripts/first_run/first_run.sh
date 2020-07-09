#!/bin/sh

cd /home/certs/store/
 touch  /home/certs/home/store/.rnd
 
 for dir in 'system/pending_csr system/saved system/completed_csr imported external_ca/completed_csr external_ca/pending_csr  external_ca/certs external_ca/keys'
 do
   if ! test -d $dir
    then 
     mkdir -p $dir
   fi
 done

