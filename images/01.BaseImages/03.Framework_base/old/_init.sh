#!/bin/sh

if ! test -f /home/engines/run/flags/built
 then
   touch /home/engines/run/flags/built
fi
 
if ! test -f /home/engines/run/flags/ca-update
 then
   sudo -n /home/engines/scripts/_update_ca.sh		
fi

