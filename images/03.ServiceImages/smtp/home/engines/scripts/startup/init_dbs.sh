#!/bin/bash

for map_file in transport generic smarthost_passwd
 do 
  if ! test -f /etc/postfix/${map_file}.db
   then
    sudo -n /home/engines/scripts/engine/_postmap.sh ${map_file}
  fi  
 done 