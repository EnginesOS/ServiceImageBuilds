#!/bin/bash

sudo -n /home/engines/scripts/startup/sudo/_setup_dirs.sh

for map_file in transport generic smarthost_passwd aliases/aliases
 do 
  if ! test -f /etc/postfix/${map_file}.db
   then
    sudo -n /home/engines/scripts/engine/sudo/_postmap.sh ${map_file}
  fi  
done 